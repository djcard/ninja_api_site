/**
 * My BDD Test
 */
component extends="coldbox.system.testing.BaseTestCase" {

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
		describe( "My First Suite", function(){
			beforeEach( function(){
				testObj = getInstance( "skills@ninja" );
			} );
			it( "A Spec", function(){
				testObj.saveSkillLevel( 1, "rockWall", 3 );
			} );
		} );
	}

}

