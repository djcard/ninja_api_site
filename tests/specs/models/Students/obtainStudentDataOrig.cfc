/**
 * My BDD Test
 */
component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/
	// executes before all suites+specs in the run() method
	function beforeAll(){
		super.beforeAll();
		variables.testboxMockingUtils = getInstance( "mocking@testboxMockingUtils" );
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
		variables.testboxMockingUtils.reloadModule( "qb" );
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		// all your suites go here.
		describe( "Obtain Student Data should", function(){
			beforeEach( function(){
				testObj = createMock( object = getInstance( "models.students" ) );
				testme  = testObj.obtainStudentDataOrig();
			} );
			it( "should return a query instance", function(){
				expect( true ).tobeFalse();
				// expect(testme).toBeInstanceOf("query");
			} );
			it( "The datasource should be ninja", function(){
				expect( true ).tobeFalse();
				// expect(testme.getAttributes()).toBeTypeOf("struct");
				// expect(testme.getAttributes()).toHaveKey("datasource");
				// expect(testme.getAttributes().datasource).toBe("ninja");
				// expect(testme.getAttributes()).toHaveKey("sql");
				// expect(testme.getAttributes().sql.findNoCase("select *")).toBegt(-1);
				// expect(testme.getAttributes().sql.findNoCase("from students")).toBegt(-1);
			} );
			it( "The sql should select * from students", function(){
				expect( true ).tobeFalse();
				// expect(testme.getAttributes()).toBeTypeOf("struct");
				// expect(testme.getAttributes()).toHaveKey("sql");
				// expect(testme.getAttributes().sql.findNoCase("select *")).toBegt(-1);
				// expect(testme.getAttributes().sql.findNoCase("from students")).toBegt(-1);
			} );
			it( "If an id is submitted, there should be a where clause", function(){
				expect( true ).tobeFalse();
				// var fakeid = randrange(1,100);
				// testme = testObj.obtainStudentDataOrig( fakeid );
				// expect(testme.getAttributes()).toBeTypeOf("struct");
				// expect(testme.getAttributes()).toHaveKey("sql");
				// expect(testme.getAttributes().sql.findNoCase("where id = :id")).toBegt(-1);
			} );
			it( "If an id is submitted, the id should be parameterized as a CF_SQL_INTEGER and should match what is submitted", function(){
				expect( true ).tobeFalse();
				// var fakeid = randrange(1,100);
				// testme = testObj.obtainStudentDataOrig( fakeid );
				// expect(testme.getParams()).toBeTypeOf("array");
				// expect(testme.getParams().len()).toBe(1);
				// expect(testme.getParams()[1].name).toBe("id");
				// expect(testme.getParams()[1].value).toBe(fakeid);
				// expect(testme.getParams()[1].cfsqltype	).toBe("CF_SQL_INTEGER");
			} );
		} );
	}

}

