component extends="coldbox.system.testing.basetestcase" {

	function beforeAll(){
		super.beforeAll();
		super.setup();
	}


	function run( testResults, testBox ){
		describe( "findStudentLevel should...", function(){
			beforeEach( function(){
				lowestAmount  = randRange( 0, 4 );
				// writeDump(lowestAmount);
				studentSkills = [];

				for ( var x = 1; x < randRange( 2, 100 ); x = x + 1 ) {
					studentSkills.append( createSkill( lowestAmount ) );
				}
				insertedIndex = randRange( 1, studentSkills.len() );
				studentSkills = studentSkills.insertAt( insertedIndex, { "skillLevel" : lowestAmount } );
				// writeDump(studentSkills);
				testObj       = getInstance( "models.students" );

				// writeDump(testme);
			} );
			it( "return a number", function(){
				var testme = testObj.findStudentLevel( [] );
				expect( testme ).toBeTypeOf( "numeric" );
			} );
			it( "By default it should return a 10", function(){
				var testme = testObj.findStudentLevel( [] );
				expect( testObj.findStudentLevel( [] ) ).tobe( 10 );
			} );
			it( "When an array of skillLevels is submitted, return the lowest", function(){
				var testme = testObj.findStudentLevel( studentSkills );
				expect( testme ).tobe( lowestAmount );
			} );
			it( "Handle if the skill Level is not a number", function(){
				insertedIndex     = insertedIndex == studentSkills.len() ? insertedIndex - 1 : insertedIndex;
				var studentSkills = studentSkills.insertAt( insertedIndex, { "skillLevel" : "q" } );
				// writeDump(studentSkills);
				var testme        = testObj.findStudentLevel( studentSkills );
				expect( testme ).tobe( lowestAmount );
			} );
			it( "Handle if the skillLevel key was not there", function(){
				insertedIndex = insertedIndex == studentSkills.len() ? insertedIndex - 1 : insertedIndex;
				studentSkills[ insertedIndex == 1 ? insertedIndex + 1 : insertedIndex - 1 ].delete( "skillLevel" );
				// writeDump(studentSkills);
				var testme = testObj.findStudentLevel( studentSkills );
				expect( testme ).tobe( lowestAmount );
			} );
		} );
	}

	function createSkill( required number lowest ){
		return { "skillLevel" : randRange( lowest + 1, lowest + 100 ) };
	}

}
