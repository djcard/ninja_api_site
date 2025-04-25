component extends="coldbox.system.testing.BaseTestCase" accessors=true {
	function beforeAll(){
		variables.testboxMockingUtils = getInstance( "mocking@testboxMockingUtils" );
		variables.testboxMockingUtils.storeOriginalMapping("skills@ninja");
		//writeDump(getInstance("skills@ninja"));
	}

	function afterAll(){
		variables.testboxMockingUtils.restoreMappings();
	}


	function run( testResults, testBox ){
		describe("Index should...",function(){
			beforeEach(function(){
				mockSkills = createMock(object=getInstance("skills@ninja"));
				fakeSkillsReturn = [{"myItem":mockdata($num=1,$type="words:1")[1]}];
				mockSkills.$(method="allSkills",returns=fakeSkillsReturn);
				variables.testboxMockingUtils.replaceMapping("skills@ninja",mockSkills);
				//writeDump(getInstance("skills@ninja"));
			});

			it("Should call skills.allSkills 1x",function(){
				var event     = this.get(
					route   = "/ninja/skills",
					headers = { },
					params  = {}
					);

				expect(mockSkills.$count("allSkills")).tobe(1);
			});
			it("Teh data should be the response from skills.",function(){
				var event     = this.get(
					route   = "/ninja/skills",
					headers = { },
					params  = {}
					);

					expect(mockSkills.$count("allSkills")).tobe(1);
			});
		});
	}
}
