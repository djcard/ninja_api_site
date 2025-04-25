component extends="coldbox.system.resthandler" {

	property name="studentService" inject="models.students";
	function index( event, rc, prc ){
		prc.response.setData( studentService.obtainStudentData() );
	}

	function show( event, rc, prc ){
		return prc.response.setData( studentService.obtainStudentData( rc.id ) );
	}

	function studentSkills( event, rc, prc ){
		prc.response.setData( studentService.studentSkills( rc.keyExists( "id" ) ? rc.id : 0 ) );
	}

	function displayData( event, rc, prc ){
		prc.studentData    = studentService.createStudentArray( rc.keyExists( "id" ) ? rc.id : 0 );
		prc.tableTemplate  = getInstance( "Table@uime" );
		prc.welcomeMessage = "Welcome to Ninja!";
		event.setLayout( "index" );
		event.setView( "ninja" );
	}

	function bumpSkills( event, rc, prc ){
		students.bumpSkills( rc.studentId, rc.skillId );
	}

}
