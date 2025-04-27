component extends="coldbox.system.testing.BaseTestCase" accessors=true {
	function beforeAll(){
		variables.testboxMockingUtils = getInstance( "mocking@testboxMockingUtils" );
		variables.testboxMockingUtils.storeOriginalMapping("models.skills");
		//writeDump(getInstance("models.skills"));
	}

	function afterAll(){
		variables.testboxMockingUtils.restoreMappings();
		//writeDump(getInstance("models.skills"));
	}


	function run( testResults, testBox ){
		describe("Index should...",function(){
			beforeEach(function(){
				mockSkills = createMock(object=getInstance("models.skills"));
				fakeSkillsReturn = [{"myItem":mockdata($num=1,$type="words:1")[1]}];
				mockSkills.$(method="allSkills",returns=fakeSkillsReturn);
				variables.testboxMockingUtils.replaceMapping("models.skills",mockSkills);
				//writeDump(getInstance("models.skills"));
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
