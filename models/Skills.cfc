component {

	property name="qb"      inject="provider:QueryBuilder@qb";
	property name="wirebox" inject="wirebox";

	function allSkills( code = "" ){
		try {
			return qb
				.from( "skills" )
				.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
				.when( code.len() > 0, function( q ){
					q.where( "skillCode", "=", code );
				} )
				.get( options = { datasource : "ninja" } );
		} catch ( any err ) {
		}
		systemOutput( "Using JSON for Skills Data" );
		return skillDataJson();
	}

	function dataSourceExists( dsourceName = "ninja" ){
		writeDump( getApplicationSettings() );
		writeDump( server );
	}

	function skillDataJson(){
		return [
			{
				"code"   : "boxJump",
				"name"   : "JSON Box Jump",
				"active" : 1
			},
			{ "code" : "rings", "name" : "Rings", "active" : 1 },
			{ "code" : "rockWall", "name" : "Rock Wall", "active" : 1 },
			{
				"code"   : "ropeClimb",
				"name"   : "Rope Climb",
				"active" : 1
			},
			{
				"code"   : "spiderCrawl",
				"name"   : "Spider Crawl",
				"active" : 1
			},
			{ "code" : "vault", "name" : "Vault", "active" : 1 }
		];
	}

	function saveSkillLevel( studentId, skillCode, skillLevel ){
		qb.setGrammar( wirebox.getInstance( "SqlServerGrammar@qb" ) )
			.from( "studentSkill" )
			.updateOrInsert(
				{
					studentId  : studentId,
					skillCode  : skillCode,
					skillLevel : skillLevel
				},
				{ datasource : "ninja" }
			);
	}

}
