component extends="coldbox.system.testing.basetestcase" {

	function beforeAll(){
		super.beforeAll();
	}

	function run( testResults, testBox ){
		describe( "CreateStudentRows should", function(){
			beforeEach( function(){
				fakeStudentData = [];
				for ( var x = 1; x <= randRange( 2, 500 ); x = x + 1 ) {
					fakeStudentData.append( createStudent() );
				}
				writeDump( fakeStudentData );
				fakeSkillInfo   = [];
				fakeSkillLevels = {};

				testObj = createMock( object = getInstance( "models.students" ) );
				testObj.$( method = "createStudentBase" );



				testme = testObj.createStudentRows(
					fakeStudentData,
					fakeSkillInfo,
					fakeSkillLevels
				);
			} );
			it( "Return an array", function(){
				expect( testme ).toBeTypeOf( "array" );
			} );
			it( "The returned array should be the same length as the student array that was passed in", function(){
				expect( testme.len() ).tobe( fakeStudentData.len() );
			} );
			it( "It should call createStudentBase the same number of times as the submitted student array", function(){
				expect( testObj.$count( "createStudentBase" ) ).tobe( fakeStudentData.len() );
			} );
		} );
	}

	function createStudent(){
		return mockData(
			$num      = 1,
			firstname = "fname",
			lastname  = "lname"
		)[ 1 ];
	}

}
