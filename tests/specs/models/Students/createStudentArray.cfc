component extends="coldbox.system.testing.basetestcase" {

	function beforeAll(){
		super.beforeAll();

		super.setup();
	}

	function run( testResults, testBox ){
		describe( "CreateStudentAnalysis should", function(){
			beforeEach( function(){
				fakeAccount      = randRange( 1, 1000 );
				fakeData         = skillsReturn();
				fakeHeaderReturn = [ createFakeReturn() ];

				fakeSkills = createMock( object = getInstance( "models.skills" ) );
				fakeSkills.$( method = "allSkills", returns = fakeData )


				fakeRowReturn = [];
				for ( var x = 1; x <= randRange( 1, 10 ); x = x + 1 ) {
					fakeRowReturn.append( createFakeReturn() );
				}

				testObj = createMock( object = getinstance( "models.students" ) );
				testObj.$( method = "createHeaderRow", returns = fakeHeaderReturn );
				testObj.$( method = "createStudentRows", returns = fakeRowReturn );
				testObj.setSkillService( fakeSkills )
				testme = testObj.createStudentArray( fakeAccount );
			} );
			it( "Should return an array", function(){
				expect( testme ).toBeTypeOf( "array", "It did not return an array" );
			} );
			it( "Should call createHeaderRow 1x", function(){
				expect( testObj.$count( "createHeaderRow" ) ).tobe(
					1,
					"Called createHeaderRow the wrong number of times"
				);
			} );
			it( "Should call createStudentRows 1x", function(){
				expect( testObj.$count( "createStudentRows" ) ).tobe(
					1,
					"Called createStudentRows the wrong number of times"
				);
			} );
			it( "The first row should have the keys: contents and classes. Contents is the return from createHeaderRow and classes should be an empty string ", function(){
				expect( testme ).toBeTypeOf( "array", "It did not return an array" );
				expect( testme.len() ).tobegt( 0, "The length of the returned array was 0" );
				expect( testme[ 1 ] ).toBeTypeOf( "struct", "The first key was not a struct" );
				expect( testme[ 1 ] ).tohavekey( "classes", "There was no classes key" );
				expect( testme[ 1 ].classes.len() ).tobe( 0, "Classes was not empty" );
				expect( testme[ 1 ] ).toHaveKey( "contents", "There was no contents key" );
				expect( testme[ 1 ].contents ).toBeTypeOf( "array", "Contents was not an array" );
				expect( testme[ 1 ].contents.len() ).toBeGT( 0, "Contents had the wrong length" );
				expect( testme[ 1 ].contents[ 1 ] ).tohaveKey(
					"testValue",
					"The first item did not have contents"
				);
				expect( testme[ 1 ].contents[ 1 ].testValue ).tobe(
					fakeHeaderReturn[ 1 ].testValue,
					"Test value was not correct"
				);
			} );
			it( "If the createStudentRows returns empty, the result should have 1 row", function(){
				testObj.$( method = "createStudentRows", returns = [] );
				var testme = testObj.createStudentArray( fakeAccount );
				expect( testme.len() ).tobe( 1 );
			} );
			it( "The returned Array should be 1 more than the return from createStudentRows", function(){
				testObj.$( method = "createStudentRows", returns = fakeRowReturn );
				var testme = testObj.createStudentArray( fakeAccount );
				expect( testme.len() ).tobe( fakeRowReturn.len() + 1 );
			} );
			it( "The indicies 2 through the end should correspond with values in the submitted data", function(){
				var testme = testObj.createStudentArray( fakeAccount );
				// writeDump(testme);
				testme.each( function( item, index ){
					if ( index > 1 ) {
						expect( item.testValue ).tobe( fakeRowReturn[ index - 1 ].testValue );
					}
				} );
			} );
			it( "When calling createStudentRow, the call should pass in the argument.id", function(){
				// writeDump(testObj);
				expect( testObj.$callLog() ).toHaveKey( "createStudentRows" );
				expect( testObj.$callLog().createStudentRows.len() ).tobe( 1 );
				expect( testObj.$callLog().createStudentRows[ 1 ].len() ).tobe( 1 );
				expect( testObj.$callLog().createStudentRows[ 1 ][ 1 ] ).tobe( fakeAccount );
			} );
		} );
	}

	function createFakeReturn(){
		return { "testValue" : mockdata( $num = 1, $type = "words:5" )[ 1 ] };
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
