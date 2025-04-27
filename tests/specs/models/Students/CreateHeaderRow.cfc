component extends="coldbox.system.testing.basetestcase" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();
	}


	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		describe( "CreateHeaderRow should...", function(){
			beforeEach( function(){
				fakeData = skillsReturn();

				testObj = getInstance( "models.students" );

				testme = testObj.createHeaderRow( fakeData );
			} );
			it( "Return an array", function(){
				expect( testme ).toBeTypeOf( "Array", "The returned Type was incorrect." );
				expect( testme.len() ).toBe( fakeData.len() + 2 );
			} );
			it( "Each index in the array should have the keys `classes`, `contents` and `header`", function(){
				expect( testme ).toBeTypeOf( "Array", "The returned Type was incorrect." );
				testme.each( function( item ){
					expect( item ).tobeStruct( "Item was not a struct" );
					expect( item ).toHaveKey( "classes" );
					expect( item ).toHaveKey( "contents" );
					expect( item ).toHaveKey( "header" );
				} );
			} );
			it( "Header should always be true", function(){
				testme.each( function( item ){
					expect( item.header ).tobeTrue();
				} );
			} );
			it( "Classes should always be blank", function(){
				testme.each( function( item ){
					expect( item.classes.len() ).tobe( 0 );
				} );
			} );
			it( "The first index back should be classes blank, header true and contents empty", function(){
				expect( testme ).toBeTypeOf( "Array", "The returned Type was incorrect." );
				expect( testme[ 1 ].classes.len() ).tobe( 0, "Classes was not blank" );
				expect( testme[ 1 ].header ).tobeTrue( "The header values was false." );
				expect( testme[ 1 ].contents.len() ).tobe( 0 );
			} );

			it( "By default indicies 2-7  - classes should be empty, header should be true, and contents = the value submitted", function(){
				expect( testme ).toBeTypeOf( "Array", "The returned Type was incorrect." );
				testme.each( function( item, index ){
					if ( index > 1 && index <= fakeData.len() + 1 ) {
						expect( item ).tobeStruct( "Item was not a struct" );
						expect( item.classes.len() ).toBe( 0, "Classes was not empty" );
						expect( item.header ).tobeTrue( "Header was not true" );
						expect( item.contents ).tobe( fakeData[ index - 1 ].name );
					}
				} );
			} );
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

}
