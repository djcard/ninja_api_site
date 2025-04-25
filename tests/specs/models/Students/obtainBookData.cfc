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
		describe( "ObtainStyle should", function(){
			beforeEach( function(){
				testObj  = createMock( object = getInstance( "models.students" ) );
				fakeISBN = mockdata( $type = "words:1", $num = 1 )[ 1 ];
				testme   = testObj.obtainBookData( fakeISBN );
			} );
			it( "The base URL should be https://openlibrary.org/api/books", function(){
				expect( testme.getURL() ).tobe( "https://openlibrary.org/api/books" );
			} );
			it( "There should be 2 headers: bibkeys and format", function(){
				var keys      = [ "bibKeys", "format" ];
				var unmatched = testme
					.getQueryParams()
					.filter( function( item ){
						return keys.findNoCase( item.name ) == 0;
					} );
				expect( unmatched.len() ).tobe( 0 );
			} );
			it( "The format is `json` ", function(){
				var matched = testme
					.getQueryParams()
					.filter( function( item ){
						return item.name == "format" && item.value == "json";
					} );
			} );
			it( "The bibkeys should be `ISBN:` and the submitted isbn ", function(){
				var matched = testme
					.getQueryParams()
					.filter( function( item ){
						return item.name == "bibkeys" && item.value == "ISBN:#fakeISBN#";
					} );
			} );
			it( "The rest of the settings should be the defaults", function(){
				expect( testme.getResolveUrls() ).tobeFalse();
				expect( testme.getencodeUrl() ).tobeTrue();
				expect( testme.getMethod() ).tobe( "get" );
				expect( testme.getTimeout() ).tobe( 10 );
				expect( testme.getbodyFormat() ).tobe( "json" );
				expect( testme.getAuthType() ).tobe( "BASIC" );
			} );
		} );
	}

}

