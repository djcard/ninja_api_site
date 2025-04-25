/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		super.setup();
		variables.testboxMockingUtils = getInstance( "mocking@testboxMockingUtils" );
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		variables.testboxMockingUtils.reloadModule( "qb" );
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStyle should", function(){
			beforeEach( function(){
				// mockQb = createMock( object = getInstance( "queryBuilder@qb" ) );
				// mockQb.$( method = "get" );

				// testObj = createMock( object = getInstance( "models.students" ) );
				// testObj.setQb( mockQb );
				// testme = testObj.obtainStudentData();
			} );
			it( "from should be students", function(){
				expect( true ).tobeFalse();
				// expect( mockQb.getFrom() ).tobe( "students" );
			} );
			it( "If no id is submitted, there should be no where", function(){
				expect( true ).tobeFalse();
				// expect( mockQb.getWheres().len() ).tobe( 0 );
			} );
			it( "If an id is submitted, there should be 1 where clause", function(){
				expect( true ).tobeFalse();
				// var fakeid = randRange( 1, 10000 );
				// var testme = testObj.obtainStudentData( fakeid );
				// expect( mockQb.getWheres().len() ).tobe( 1 );
				// expect( mockQb.getWheres()[ 1 ].column ).tobe( "id" );
				// expect( mockQb.getWheres()[ 1 ].combinator ).tobe( "and" );
				// expect( mockQb.getWheres()[ 1 ].operator ).tobe( "=" );
				// expect( mockQb.getWheres()[ 1 ].type ).tobe( "basic" );
				// expect( mockQb.getWheres()[ 1 ].value ).tobe( fakeId );
			} );
		} );
	}

}

