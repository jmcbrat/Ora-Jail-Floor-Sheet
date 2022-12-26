CREATE OR REPLACE
function MCMB_RPT_Floor_Sheet
	(p_Floor		in			eh_housing_assignments.location_id%type)
return epp_generic_ref_cursor.ref_cursor is

	vCur				epp_generic_ref_cursor.ref_cursor;
	
begin

	open vCur for	
    select
        ef_offender_id(ep.entity_id) as "Inmate #",
		EF_GET_PERSONORORGNAME(bk.entity_id) as "Name",
        substr(EF_LOCATION_PATH_NAME(ha.location_id,'uc',5),1,instr(EF_LOCATION_PATH_NAME(ha.location_id,'uc',5),',',1)-1) as "Floor",
		ef_location_name(ha.location_id,'uc') as "Cell",
		mcmb_fnt_alphabin(bk.entity_id) as "Bin",
		TO_CHAR(substr(ef_epic_date_to_date(epi.date_of_birth),1,10)) as "DOB",
		ef_lookup_text ('SECURITY CLASSIFICATION', ef_get_Security_Class(bk.entity_id), 'UC') as "Security Class",
		mcmb_fnt_alphafunds(bk.entity_id) as "Funds", --ASK BOB ABOUT THIS.
		mcmb_active_alerts(bk.entity_id) as "Active Alerts"
    from
		eh_housing_assignments ha,
		eh_active_booking ab,
		eh_booking bk,
		eh_person_identity epi,
		eh_entity_person ep
	where ha.entity_id (+) = ab.entity_id
    	and ep.entity_id = ab.entity_id
		and  bk.booking_id = ab.booking_id
		and epi.entity_id = ab.entity_id
		and decode(epi.identity_id, ep.primary_identity_id, 'P', 'A') = 'P'
		and substr(EF_LOCATION_PATH_NAME(ha.location_id,'uc',5),1,instr(EF_LOCATION_PATH_NAME(ha.location_id,'uc',5),',',1)-1) = p_Floor
	order by "Floor";

	return vCur;
	
end;
	
/
