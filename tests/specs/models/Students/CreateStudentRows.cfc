component extends="coldbox.system.testing.basetestcase" {

	function beforeAll(){
		super.beforeAll();
	}

	function run( testResults, testBox ){
		describe( "CreateStudentRows should", function(){
			beforeEach( function(){
				fakeStudentData = [];
				for ( var x = 1; x <= randRange( 2, 500 ); x = x + 1 ) {
					fakeStudentData.append( createStudent( x ) );
				}

				firstName = mockData( $num = 1, $type = "fname" )[ 1 ];
				lastName  = mockData( $num = 1, $type = "lname" )[ 1 ];

				fakeStudentBase = {
					"classes"  : "",
					"contents" : [
						{
							"contents" : firstName & " " & left( lastName, 1 ).ucase(),
							"header"   : false,
							"classes"  : ""
						}
					]
				};


				fakeSkillsReturn = skillsReturn();
				fakeSkills       = createMock( object = getInstance( "models.skills" ) );
				fakeSkills.$( method = "allSkills", returns = fakeSkillsReturn )

				fakeSkillInfo   = [];
				fakeSkillLevels = {};

				testObj = createMock( object = getInstance( "models.students" ) );
				testObj.$( method = "createStudentBase", returns = fakeStudentBase );
				testObj.$( method = "obtainStudentData", returns = fakeStudentData );

				testObj.$( method = "createStudentSkillDictionary", returns = makeDict( fakeStudentData ) );


				testObj.setSkillService( fakeSkills );


				testme = testObj.createStudentRows( 0 );
			} );
			it( "Return an array", function(){
				expect( testme ).toBeTypeOf( "array" );
			} );
			it( "The returned array should be the same length as the student array that was passed in", function(){
				expect( testme.len() ).tobe( fakeStudentData.len() );
			} );
			it( "It should call createStudentBase the same number of times as the submitted student array", function(){
				expect( testObj.$count( "createStudentBase" ) ).tobe( fakeStudentData.len() );
			} );
		} );
	}

	function createStudent( id ){
		return mockData(
			$num      = 1,
			firstname = "fname",
			lastname  = "lname"
		)[ 1 ].append( {
			"id"        : arguments.id,
			"studentId" : arguments.id,
			"skillCode" : randRange( 1, 10 ),
			skillLevel  : randRange( 1, 10 )
		} );
	}

	function skillsReturn(){
		return [
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "#mockdata( $num = 1, $type = "words:3" )[ 1 ]#",
				"active" : 1
			},
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "Rings",
				"active" : 1
			},
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "#mockdata( $num = 1, $type = "words:3" )[ 1 ]#",
				"active" : 1
			},
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "#mockdata( $num = 1, $type = "words:3" )[ 1 ]#",
				"active" : 1
			},
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "#mockdata( $num = 1, $type = "words:3" )[ 1 ]#",
				"active" : 1
			},
			{
				"code"   : "#mockdata( $num = 1, $type = "words:1" )[ 1 ]#",
				"name"   : "#mockdata( $num = 1, $type = "words:3" )[ 1 ]#",
				"active" : 1
			}
		];
	}

	function makeDict( studentData ){
		var returnMe = {};
		studentData.each( function( item ){
			returnMe[ item.studentId.toString() ] = returnMe.keyExists( item.studentId.toString() ) ? returnMe[
				item.studentId.toString()
			] : {};
			returnMe[ item.studentId.toString() ][ item.skillCode ] = item.skillLevel;
		} );
		return returnMe;
	}

}
