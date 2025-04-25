component accessors="true" {

	property name="qb"           inject="provider:QueryBuilder@qb";
	property name="wirebox"      inject="wirebox";
	property name="skillService" inject="models.skills";
	property name="hyper"        inject="HyperBuilder@Hyper";
	property name="maxLevel" default="6";

	function init(){
		return this;
	}


	/***
	 * Returns the CSS class corresponding with the submitted skill level
	 *
	 * @value - A numeric value, typically 1-6 as of 23 Jun 2023
	 **/
	string function obtainStyle( required numeric value ){
		return "level#value#";
	}



	/***
	 * Creates the array of student skill and level data needed to create the display table
	 *
	 * @id optional numeric student id.
	 **/
	function createStudentArray( numeric id = 0 ){
		var tableData   = [ { "contents" : createHeaderRow(), "classes" : "" } ];
		// /writeDump(tableData);
		var studentRows = createStudentRows( arguments.id );

		return isNull( studentRows ) ? tableData : tableData.append( studentRows, true );
	}

	/***
	 * This is here as an example of mocking queries. Obtains student information from the datbase
	 * Would require running execute().getResult() separately.
	 *
	 * @id The id for a student (optional)
	 **/
	function obtainStudentDataORIG( numeric id = 0 ){
		var q   = new query( datasource = "ninja" );
		var sql = "select * from students";
		sql     = arguments.id > 0 ? sql & " where id = :id " : sql;
		if ( arguments.id > 0 ) {
			q.addParam(
				name      = "id",
				value     = arguments.id,
				cfsqltype = "CF_SQL_INTEGER"
			);
		}
		q.setSql( sql );
		return q;
	}

	function executeQuery( q ){
		return q.execute().getResult();
	}


	/***
	 * A QB based query with options. This is use in the actual app. If there is an error, return the JSON data
	 *
	 * @id The id of a student (optional)
	 **/
	function obtainStudentData( numeric id = 0 ){
		try {
			return qb
				.from( "students" )
				.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
				.when( id > 0, function( q ){
					q.where( "id", "=", id );
				} )
				.get( options = { datasource : "ninja" } );
		} catch ( any err ) {
			systemOutput( "Using JSON for Student Data" );
			return studentDataJSON();
		}
	}

	function studentDataJSON(){
		return [
			{
				"id"        : 1,
				"firstname" : "JSON Tracy",
				"lastname"  : "Jones"
			},
			{ "id" : 2, "firstname" : "Timmy", "lastname" : "Newman" },
			{ "id" : 3, "firstname" : "Paul", "lastname" : "Giovanni" },
			{
				"id"        : 4,
				"firstname" : "Jackson",
				"lastname"  : "Poldark"
			}
		];
	}

	/***
	 * Creates the top header for the skills display table. The first column should be blank and each subsequent be the name of a skill.
	 *
	 * @headerData - an array of structs, each must have the key `name`
	 **/
	Array function createHeaderRow(){
		var allSkills = skillService.allSkills();
		var base      = [ { "header" : true, "contents" : "", "classes" : "" } ];
		allSkills.each( function( item ){
			base.append( { "header" : true, "contents" : item.name, "classes" : "" } );
		} );

		base.append( { "header" : true, "contents" : "Level", "classes" : "" } );

		return base;
	}


	/***
	 * Accepts an array of skillLevels and returns the lowest level
	 *
	 * @skillData - an array of structs, each with the key skillLevel
	 **/
	function findStudentLevel( required array skillData = studentData, string keyName = "skillLevel" ){
		return skillData.reduce( function( currLevel, item ){
			// writeDump(item[ keyName ]);
			// writeDump(item[ keyName ] < currLevel ? item[ keyName ] : currLevel);
			return item[ keyName ] < currLevel ? item[ keyName ] : currLevel;
		}, 10 );
	}

	/***
	 * Queries the database and returns all skill levels for all students unless a studentId is submitted (all skills for that student), a skillCode (all scores for that skillCode) or both ( a particular skill for a particular student)
	 *
	 * @studentId - numeric id for a student
	 * @skillCode -
	 **/
	function studentSkills( numeric studentId = 0, string skillCode = "" ){
		try {
			return qb
				.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
				.from( "studentSkill" )
				.when( studentId > 0, function( q ){
					q.where( "studentId", "=", studentId );
				} )
				.when( skillCode.len() > 0, function(){
					q.where( "skillCode", "=", skillCode );
				} )
				.get( options = { datasource : "ninja" } );
		} catch ( any err ) {
			systemOutput( "Using JSON for Student Skill Data" );
			var alldata = studentSkillJSON();
			systemOutput( " There was an error looking for student skills" );
			systemOutput( err );
			if ( studentId && skillCode ) {
				systemOutput( "returning skill skills for #arguments.studentId# and skill #arguments.skillCode#" );
				return alldata.filter( function( item ){
					return item.studentid == arguments.studentId && item.skillCode == arguments.skillCode;
				} );
			} else {
				return allData;
			}
		}
	}

	function studentSkillJSON(){
		return [
			{
				"studentId"  : 1,
				"skillCode"  : "rockWall",
				"skillLevel" : 10000
			},
			{
				"studentId"  : 1,
				"skillCode"  : "ropeClimb",
				"skillLevel" : 1
			},
			{ "studentId" : 1, "skillCode" : "rings", "skillLevel" : 3 },
			{
				"studentId"  : 1,
				"skillCode"  : "boxJump",
				"skillLevel" : 4
			},
			{
				"studentId"  : 1,
				"skillCode"  : "spiderCrawl",
				"skillLevel" : 1
			},
			{ "studentId" : 1, "skillCode" : "vault", "skillLevel" : 5 }
		];
	}


	function createStudentSkillDictionary(){
		var returnMe    = {};
		var studentdata = studentSkills();
		studentData.each( function( item ){
			returnMe[ item.studentId.toString() ] = returnMe.keyExists( item.studentId.toString() ) ? returnMe[
				item.studentId.toString()
			] : {};
			returnMe[ item.studentId.toString() ][ item.skillCode ] = item.skillLevel;
		} );

		return returnMe;
	}






	/***
	 *
	 * Creates each row of student Each column (cell) pertains to a skill and the number in the cell is the level the student is on.
	 *
	 * @studentData - Array of Structs referring to student names. Must have firstname, lastname, and id
	 * @allSkills   - Array of Structs referring to the skills taught by the gym. Must have key `code`
	 * @skillData   - Struct with students IDs as the first key and skillCode as the next level in with the skill level as the value
	 ***/
	array function createStudentRows( required numeric id = 0 ){
		var returnMe = [];

		var studentData = obtainStudentData( id );
		var allSkills   = skillService.allSkills();
		var skillData   = createStudentSkillDictionary();


		// Loop Over the student array
		studentData.each( function( student ){
			// Create the base of the student struct
			var studentBase = createStudentBase( student.firstname, student.lastname );

			// Loop over the skills array
			allSkills.each( function( skill ){
				// Retrieve the student's recorded skill level or display a 0
				var cellValue = skillData.keyExists( student.id.toString() ) && skillData[ student.id.toString() ].keyExists(
					skill.code
				)
				 ? skillData[ student.id.toString() ][ skill.code ]
				 : 0;

				// Append this "cell" to the "row" array
				studentBase.contents.append(
					{
						"contents" : cellValue,
						"header"   : false,
						"classes"  : obtainStyle( cellValue )
					},
					true
				);
			} );

			var totalLevel = validateStudentLevel( findStudentLevel( studentBase.contents, "contents" ) );
			studentBase.contents.append( {
				"contents" : totalLevel,
				"header"   : false,
				"classes"  : obtainStyle( totalLevel )
			} );
			// Append the "row" to the returnMe array
			returnMe.append( studentBase, true );
		} );

		// Return the assembled table data
		return returnMe;
	}

	struct function createStudentBase( required string firstName = "", required string lastName = "" ){
		return {
			"classes"  : "",
			"contents" : [
				{
					"contents" : firstName & " " & left( arguments.lastName, 1 ).ucase(),
					"header"   : false,
					"classes"  : ""
				}
			]
		};
	}





	function bumpSkills( required numeric studentId, required string skillCode ){
		// Get the student's current skill from the DB
		var currentLevel = studentSkills( studentId, skillCode );

		// Do the logic to bump up the level
		var newlevel = currentLevel.len() && currentLevel[ 1 ].keyExists( "skillLevel" ) && isValid(
			"numeric",
			currentLevel[ 1 ].skillLevel
		)
		 ? currentLevel[ 1 ].skillLevel + 1
		 : 1;

		// Access the skill service and save the new skill level in the DB
		skillService.saveSkillLevel( studentId, skillCode, newlevel );
		return true;
	}

	function obtainBookData( isbn = "9780062196538" ){
		return hyper
			.setMethod( "get" )
			.setURL( "https://openlibrary.org/api/books?bibkeys=ISBN:#arguments.isbn#&format=json" );
	}

	function sendHyper( hyp ){
		return hyp.send();
	}

	function validateStudentLevel( required numeric level ){
		return level <= maxLevel ? level : 0;
	}

}
