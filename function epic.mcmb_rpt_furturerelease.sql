CREATE OR REPLACE
function MCMB_RPT_FurtureRelease
	(p_StartDate		in			date,
	 p_EndDate          in          date)
return epp_generic_ref_cursor.ref_cursor is

	vCur				epp_generic_ref_cursor.ref_cursor;
	
begin

	open vCur for	
	Select  ef_offender_id(ep.entity_id) as "Inmate #",
			EF_GET_PERSONORORGNAME(bk.entity_id) as "Name",
			ef_location_name(ha.location_id,'uc') as "Cell",
			mcmb_rpt_alphabin(bk.entity_id) as "prop",
			'' as "funds"
	from  eh_active_booking ab,
    	  eh_booking bk,
	  	  eh_housing_assignments ha,
		  eh_entity_person ep
	where ab.entity_id  = ha.entity_id
	  and ab.entity_id  = ep.entity_id
	  and ab.booking_id = bk.booking_id
	  and (ef_epic_date_to_date(bk.FINAL_RELEASE_DATE) >= p_StartDate
	  and  ef_epic_date_to_date(bk.FINAL_RELEASE_DATE) <= p_EndDate);

	return vCur;
	
end;
/
