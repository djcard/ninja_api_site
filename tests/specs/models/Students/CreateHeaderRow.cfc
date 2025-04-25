/**
 * The base model test case will use the 'model' annotation as the instantiation path
 * and then create it, prepare it for mocking and then place it in the variables scope as 'model'. It is your
 * responsibility to update the model annotation instantiation path and init your model.
 */
component extends="coldbox.system.testing.BaseModelTest" model="ninja.models.Students" {

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		super.beforeAll();

		// setup the model
		super.setup();

		// init the model object
		model.init();
	}

	function afterAll(){
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run( testResults, testBox ){
		describe( "CreateHeaderRow should...", function(){
			beforeEach( function(){
				// fakeData = mockData($num=6, name="words:1:3");
				// testme = model.createHeaderRow( fakeData );
			} );
			it( "Return an array", function(){
				expect( true ).tobeFalse();
				// expect(testme).toBeTypeOf("Array","The returned Type was incorrect.");
				// expect(teestme.len()).toBe(7);
			} );
			it( "Each index in the array should have the keys `classes`, `contents` and `header`", function(){
				expect( true ).tobeFalse();
				// expect(testme).toBeTypeOf("Array","The returned Type was incorrect.");
				// testme.each(function(item){
				//	expect(item).tobeStruct("Item was not a struct");
				//	expect(item).toHaveKey("classes");
				//	expect(item).toHaveKey("contents");
				//	expect(item).toHaveKey("header");
				// });
			} );
			it( "Header should always be true", function(){
				expect( true ).tobeFalse();
				// testme.each( function( item ){
				//		expect( item.header ).tobeTrue();
				// } );
			} );
			it( "Classes should always be blank", function(){
				expect( true ).tobeFalse();
				// testme.each( function( item ){
				//		expect( item.classes.len() ).tobe( 0 );
				// } );
			} );
			it( "The first index back should be classes blank, header true and contents empty", function(){
				expect( true ).tobeFalse();
				// expect(testme).toBeTypeOf("Array","The returned Type was incorrect.");
				// expect(testme[1].classes.len()).tobe(0, "Classes was not blank");
				// expect(testme[1].header).tobeTrue("The header values was false.");
				// expect(testme[1].contents.len()).tobe(0);
			} );

			it( "By default indicies 2-7  - classes should be empty, header should be true, and contents = the value submitted", function(){
				expect( true ).tobeFalse();
				// expect(testme).toBeTypeOf("Array","The returned Type was incorrect.");
				// testme.each(function(item, index){
				//	if(index > 1) {
				//		expect(item).tobeStruct("Item was not a struct");
				//		expect(item.classes.len()).toBe(0, "Classes was not empty");
				//		expect(item.header).tobeTrue("Header was not true");
				//		expect(item.contents).tobe(fakeData[index-1].name);
				//	}
				// });
			} );
		} );
	}

}
