/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStyle should", function(){
			beforeEach( function(){
				fakeStudentId  = randRange( 1, 1000 );
				fakeSkillCode  = mockData( $type = "words:1", $num = 1 )[ 1 ];
				fakeSkillLevel = randRange( 1, 6 );

				fakeSkillsReturn = [
					{
						studentId  : fakeStudentId,
						skillCode  : fakeSkillCode,
						skillLevel : fakeSkillLevel
					}
				];

				mockSkillService = createMock( object = getInstance( "skills@ninja" ) );
				mockSkillService.$( method = "saveSkillLevel" );

				testObj = createMock( object = getInstance( "models.students" ) );
				testObj.$( method = "studentSkills", returns = fakeSkillsReturn );
				testObj.setSkillService( mockSkillService );
			} );
			it( "Should Run studentSkills 1x", function(){
				var testMe = testObj.bumpSkills( fakeStudentId, fakeSkillCode );
				expect( testObj.$count( "studentSkills" ) ).tobe( 1 );
			} );
			it( "Should pass in 2 arguments - studentId and skillCode", function(){
				var testMe = testObj.bumpSkills( fakeStudentId, fakeSkillCode );
				expect( testObj._MOCKCALLLOGGERS ).tohaveKey( "studentSkills" );
				expect( testObj._MOCKCALLLOGGERS.studentSkills.len() ).tobe( 1 );
				expect( testObj._MOCKCALLLOGGERS.studentSkills[ 1 ] ).toBeTypeOf( "struct" );
				expect( testObj._MOCKCALLLOGGERS.studentSkills[ 1 ].len() ).tobe( 2 );
				expect( testObj._MOCKCALLLOGGERS.studentSkills[ 1 ][ 1 ] ).tobe( fakeStudentId );
				expect( testObj._MOCKCALLLOGGERS.studentSkills[ 1 ][ 2 ] ).tobe( fakeSkillCode );
			} );

			it( "Should call skillService.saveSkillLevel 1x", function(){
				var testMe = testObj.bumpSkills( fakeStudentId, fakeSkillCode );
				expect( mockSkillService.$count( "saveSkillLevel" ) ).tobe( 1 );
			} );

			it( "Should pass in the studentId, skillCode, and the skillLevel returned from studentSkills+1", function(){
				var testMe = testObj.bumpSkills( fakeStudentId, fakeSkillCode );
				expect( mockSkillService._MOCKCALLLOGGERS ).tohaveKey( "saveSkillLevel" );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel.len() ).tobe( 1 );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ] ).toBeTypeOf( "struct" );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ].len() ).tobe( 3 );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 1 ] ).tobe( fakeStudentId );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 2 ] ).tobe( fakeSkillCode );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 3 ] ).tobe( fakeSkillLevel + 1 );
			} );
			it( "Should pass in the studentId, skillCode, and  if no skillLevel is returned from studentSkills, 1", function(){
				testObj.$( method = "studentSkills", returns = [] );

				var testMe = testObj.bumpSkills( fakeStudentId, fakeSkillCode );
				expect( mockSkillService._MOCKCALLLOGGERS ).tohaveKey( "saveSkillLevel" );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel.len() ).tobe( 1 );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ] ).toBeTypeOf( "struct" );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ].len() ).tobe( 3 );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 1 ] ).tobe( fakeStudentId );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 2 ] ).tobe( fakeSkillCode );
				expect( mockSkillService._MOCKCALLLOGGERS.saveSkillLevel[ 1 ][ 3 ] ).tobe( 1 );
			} );
		} );
	}

}

