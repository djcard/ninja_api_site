/**
* Description of task
*/
component {

	/**
	*
	*/
	function run() {
		command("cp .env.example .env").run();
		command("cp modules/ninja_api/tests/specs/ tests/specs/  --recurse").run();
	}

}
