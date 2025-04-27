/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		super.setup();
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "ObtainStudentData should", function(){
			beforeEach( function(){
				mockQb = createMock( object = getInstance( "queryBuilder@qb" ) );
				mockQb.$( method = "get" );

				testObj = createMock( object = getInstance( "models.students" ) );
				testObj.setQb( mockQb );
				testme = testObj.obtainStudentData();
			} );
			it( "the tablename should be students", function(){
				expect( mockQb.getTableName() ).tobe( "students" );
			} );
			it( "If no id is submitted, there should be no where", function(){
				expect( mockQb.getWheres().len() ).tobe( 0 );
			} );
			it( "If an id is submitted, there should be 1 where clause", function(){
				var fakeid = randRange( 1, 10000 );
				var testme = testObj.obtainStudentData( fakeid );
				expect( mockQb.getWheres().len() ).tobe( 1 );
				expect( mockQb.getWheres()[ 1 ].column ).tobe( "id" );
				expect( mockQb.getWheres()[ 1 ].combinator ).tobe( "and" );
				expect( mockQb.getWheres()[ 1 ].operator ).tobe( "=" );
				expect( mockQb.getWheres()[ 1 ].type ).tobe( "basic" );
				expect( mockQb.getWheres()[ 1 ].value ).tobe( fakeId );
			} );
		} );
	}

}

