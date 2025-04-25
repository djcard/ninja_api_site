component extends="coldbox.system.resthandler" {

	property name="skillService" inject="models.skills";

	function index( event, rc, prc ){
		prc.response.setData( skillService.allSkills() );
	}

}
