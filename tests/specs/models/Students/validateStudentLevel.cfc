component extends="coldbox.system.testing.basetestcase" {

	function beforeAll(){
		super.beforeAll();
		super.setup();
	}


	function run( testResults, testBox ){
		describe( "ValidateStudentLevel should...", function(){
			beforeEach( function(){
				testObj = getInstance( "models.students" );
			} );
			it( "return a number", function(){
				testme = testObj.validateStudentLevel( 0 );
				expect( testme ).toBeTypeOf( "numeric" );
			} );
			it( "By default the max level should be 6", function(){
				expect( testObj.getMaxLevel() ).toBe( 6 );
			} );
			it( "If the number submitted is higher than the maxLevel in the gym, return 0", function(){
				var fakeMax = randRange( 1, 1000 );
				testObj.setMaxLevel( fakeMax );
				testme = testObj.validateStudentLevel( fakeMax + randRange( 1, 10 ) );
				expect( testme ).tobe( 0 );
			} );
			it( "If the number submitted is gte 0 and less than the maxLevel in the gym, return the level", function(){
				var fakeMax = randRange( 2, 1000 );
				testObj.setMaxLevel( fakeMax );
				testme = testObj.validateStudentLevel( fakeMax - 1 );
				expect( testme ).tobe( fakeMax - 1 );
			} );
			it( "If the number submitted is lt 0 return 0", function(){
				testme = testObj.validateStudentLevel( -100 );
				expect( testme ).tobe( 0 );
			} );
		} );
	}

}
