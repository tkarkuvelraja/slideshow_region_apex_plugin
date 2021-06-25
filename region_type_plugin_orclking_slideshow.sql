prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>1830538872652277
,p_default_application_id=>1009
,p_default_id_offset=>500534566193270241
,p_default_owner=>'FXO'
);
end;
/
 
prompt APPLICATION 1009 - DAMAC Leasing
--
-- Application Export:
--   Application:     1009
--   Name:            DAMAC Leasing
--   Date and Time:   19:35 Friday June 25, 2021
--   Exported By:     KARKUVELRAJA.T
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 383634027351215608
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     218248527712390
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/region_type/orclking_slideshow
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(383634027351215608)
,p_plugin_type=>'REGION TYPE'
,p_name=>'ORCLKING.SLIDESHOW'
,p_display_name=>'Slideshow'
,p_supported_ui_types=>'DESKTOP'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_slideshow (p_region              IN apex_plugin.t_region, ',
'                                p_plugin              IN apex_plugin.t_plugin, ',
'                                p_is_printer_friendly IN boolean) ',
'RETURN apex_plugin.t_region_render_result ',
'AS ',
'  subtype plugin_attr IS VARCHAR2(32767); ',
'  l_column_value_list apex_plugin_util.t_column_value_list; ',
'  l_region            VARCHAR2(100); -- To keep region static id ',
'  l_data              CLOB; -- To store column values ',
'  l_html_body         CLOB;',
'  l_script            CLOB;',
'  l_slider            CLOB;',
'  l_starting_position_script CLOB;',
'  l_img_height        apex_application_page_regions.attribute_01%TYPE:= p_region.attribute_01;',
'  l_slideshow        apex_application_page_regions.attribute_02%TYPE:= p_region.attribute_02;',
'  l_slide_interval   apex_application_page_regions.attribute_03%TYPE:= p_region.attribute_03;',
'  l_starting_position   apex_application_page_regions.attribute_04%TYPE:= p_region.attribute_04;',
'BEGIN ',
'    -- Debug information will be logged when application''s debug mode enabled ',
'    IF apex_application.g_debug THEN ',
'      apex_plugin_util.debug_region (p_plugin => p_plugin, p_region => p_region, ',
'      p_is_printer_friendly => p_is_printer_friendly); ',
'    END IF;',
'    ',
'    -- Get region static id  ',
'    l_region := CASE ',
'                  WHEN p_region.static_id IS NOT NULL THEN p_region.static_id ',
'                  ELSE ''R'' ',
'                       ||p_region.ID ',
'                END; ',
'',
'    -- Get data from region source (sql query) ',
'    l_column_value_list := apex_plugin_util.get_data ( p_sql_statement => p_region.SOURCE, ',
'                                                       p_min_columns => 4, ',
'                                                       p_max_columns => 4, ',
'                                                       p_component_name => p_region.NAME); ',
'    ',
'    IF l_starting_position > 0 THEN',
'     IF l_starting_position > l_column_value_list(1).count THEN',
'        l_starting_position := 1;',
'     ELSE',
'        l_starting_position := l_starting_position;',
'     END IF;',
'     ',
'     l_starting_position_script := ''<script> ',
'               window.onload = function() { currentSlide(''||l_starting_position||'')};',
'              </script>'';',
'  END IF;',
'  ',
'    IF l_slideshow = ''M'' THEN',
'     l_slider := ''<a class="prev" onclick="plusSlides(-1)">&#10094;</a>',
'      <a class="next" onclick="plusSlides(1)">&#10095;</a>'';',
'      ',
'     l_script := ''<script>',
'                 var slideIndex = 1;',
'                 showSlides(slideIndex);',
'                 ',
'                 function plusSlides(n) {  ',
'                 showSlides(slideIndex += n);',
'                 }',
'                 ',
'                 function currentSlide(n) {  ',
'                 showSlides(slideIndex = n);',
'                 }',
'                 ',
'                 function showSlides(n) {  ',
'                 var i;  ',
'                 var slides = document.getElementsByClassName("mySlides");  ',
'                 var dots = document.getElementsByClassName("dot");  ',
'                 if (n > slides.length) {slideIndex = 1}      ',
'                 if (n < 1) {slideIndex = slides.length}  ',
'                 for (i = 0; i < slides.length; i++) {      ',
'                 slides[i].style.display = "none";    ',
'                 }  ',
'                 for (i = 0; i < dots.length; i++) {      ',
'                 dots[i].className = dots[i].className.replace(" active", "");  ',
'                 }  ',
'                 slides[slideIndex-1].style.display = "block";    ',
'                 dots[slideIndex-1].className += " active";',
'                 }',
'              </script>''||l_starting_position_script;',
'  ',
'  -- Add required CSS file ',
'    apex_css.add_file(p_name => ''slideshowmanual'', -- Name the CSS file, ',
'    p_directory => p_plugin.file_prefix, -- Location of the CSS file, ',
'    p_version => NULL);             ',
'  ELSif l_slideshow = ''A'' THEN  ',
'  l_slider := NULL;',
'  l_script := ''<script>',
'                var slideIndex = 0;',
'                showSlides();',
'',
'                function showSlides() {',
'                  var i;',
'                  var slides = document.getElementsByClassName("mySlides");',
'                  var dots = document.getElementsByClassName("dot");',
'                  for (i = 0; i < slides.length; i++) {',
'                    slides[i].style.display = "none";  ',
'                  }',
'                  slideIndex++;',
'                  if (slideIndex > slides.length) {slideIndex = 1}    ',
'                  for (i = 0; i < dots.length; i++) {',
'                    dots[i].className = dots[i].className.replace(" active", "");',
'                  }',
'                  slides[slideIndex-1].style.display = "block";  ',
'                  dots[slideIndex-1].className += " active";',
'                  setTimeout(showSlides, ''||nvl(l_slide_interval,3)*1000||''); // Change image every 2 seconds',
'                }',
'                </script>'';',
'      -- Add required CSS file ',
'    apex_css.add_file(p_name => ''slideshowautomatic'', -- Name the CSS file, ',
'    p_directory => p_plugin.file_prefix, -- Location of the CSS file, ',
'    p_version => NULL);             ',
'  END IF;',
'  ',
'   l_html_body := ''<!DOCTYPE html>',
'<html>',
'   <head>',
'      <meta name="viewport" content="width=device-width, initial-scale=1">',
'   </head>',
'   <body>',
'      <div class="slideshow-container">''||l_slider;',
'    ',
'    FOR i IN 1..l_column_value_list(1).count loop',
'    l_html_body := l_html_body ||'' ''||'' <div class="mySlides fade">  ',
'                  <div class="numbertext">''||l_column_value_list(2)(i)||'' / ''||l_column_value_list(1).count||''</div>  ',
'                  <div class="text">''||l_column_value_list(3)(i)||''</div>',
'                  <img src="''||l_column_value_list(4)(i)||''" style="width:100%; height:''||nvl(l_img_height,450)||''px;"> ',
'                  </div>'';',
'  END loop;',
'  ',
'       l_html_body := l_html_body ||'' ''||''</div> <br> <div style="text-align:center">'';',
'  ',
'  IF l_slideshow = ''M'' THEN ',
'  FOR j IN 1..l_column_value_list(1).count',
'  loop',
'    l_html_body := l_html_body ||'' ''||''<span class="dot" onclick="currentSlide(''||j||'')"></span>'';',
'  END loop;',
'  ELSif l_slideshow = ''A'' THEN ',
'  FOR j IN 1..l_column_value_list(1).count',
'  loop',
'    l_html_body := l_html_body ||'' ''||''<span class="dot"></span>'';',
'  END loop;',
'  END IF;',
'  ',
'  l_html_body := l_html_body ||'' ''||''</div>''||l_script||''</body></html>'';',
'',
'    sys.htp.p(l_html_body); ',
'    ',
'    RETURN NULL; ',
'END render_slideshow; '))
,p_api_version=>2
,p_render_function=>'render_slideshow'
,p_standard_attributes=>'SOURCE_SQL:AJAX_ITEMS_TO_SUBMIT:NO_DATA_FOUND_MESSAGE'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_about_url=>'https://github.com/tkarkuvelraja/slideshow_region_apex_plugin'
,p_files_version=>8
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(169862895056145219)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Img. Height'
,p_attribute_type=>'NUMBER'
,p_is_required=>false
,p_default_value=>'450'
,p_display_length=>3
,p_max_length=>3
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(169863771523173930)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Slideshow'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'M'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169864442611174801)
,p_plugin_attribute_id=>wwv_flow_api.id(169863771523173930)
,p_display_sequence=>10
,p_display_value=>'Automatic'
,p_return_value=>'A'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169865042084175307)
,p_plugin_attribute_id=>wwv_flow_api.id(169863771523173930)
,p_display_sequence=>20
,p_display_value=>'Manual'
,p_return_value=>'M'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(169872255894208041)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Slideshow Interval (Sec)'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'2'
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(169863771523173930)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'A'
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169872881271209334)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>10
,p_display_value=>'1'
,p_return_value=>'1'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169873251735209846)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>20
,p_display_value=>'2'
,p_return_value=>'2'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169873622464210275)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>30
,p_display_value=>'3'
,p_return_value=>'3'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169874079982210618)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>40
,p_display_value=>'4'
,p_return_value=>'4'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169874493788210969)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>50
,p_display_value=>'5'
,p_return_value=>'5'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169874815553211335)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>60
,p_display_value=>'6'
,p_return_value=>'6'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169875268974211696)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>70
,p_display_value=>'7'
,p_return_value=>'7'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169875616249212116)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>80
,p_display_value=>'8'
,p_return_value=>'8'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169876078812212525)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>90
,p_display_value=>'9'
,p_return_value=>'9'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(169876422243213011)
,p_plugin_attribute_id=>wwv_flow_api.id(169872255894208041)
,p_display_sequence=>100
,p_display_value=>'10'
,p_return_value=>'10'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(169883786618415671)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Starting Position'
,p_attribute_type=>'NUMBER'
,p_is_required=>true
,p_default_value=>'1'
,p_display_length=>3
,p_max_length=>3
,p_supported_ui_types=>'DESKTOP'
,p_is_translatable=>false
,p_depending_on_attribute_id=>wwv_flow_api.id(169863771523173930)
,p_depending_on_has_to_exist=>true
,p_depending_on_condition_type=>'EQUALS'
,p_depending_on_expression=>'M'
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(383636300935250362)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_name=>'SOURCE_SQL'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A0D0A202A204F7261636C65204150455820536C69646573686F772E0D0A202A20506C75672D696E20547970653A20526567696F6E0D0A202A2053756D6D6172793A204120706C7567696E20746F20646973706C617920696D61676573206173206120';
wwv_flow_api.g_varchar2_table(2) := '726573706F6E7369766520736C69646573686F772E0D0A202A0D0A202A202D2D2D2D2D20436F6E7461637420696E666F726D6174696F6E202D2D2D2D0D0A202A0D0A202A20446576656C6F706564206279202A204576616C7561746520436F6E73756C74';
wwv_flow_api.g_varchar2_table(3) := '696E672053657276696365732C2042616E67616C6F72650D0A202A20436F6E746163743A20696E666F406576616C7561746563732E636F6D0D0A202A20576562736974653A2068747470733A2F2F6576616C7561746563732E636F6D0D0A202A0D0A202A';
wwv_flow_api.g_varchar2_table(4) := '2040617574686F72204B61726B7576656C72616A61205468616E67616D617269617070616E202D20746B61726B7576656C72616A6140676D61696C2E636F6D0D0A202A2050726F66696C653A2068747470733A2F2F7777772E6C696E6B6564696E2E636F';
wwv_flow_api.g_varchar2_table(5) := '6D2F696E2F6B61726B7576656C72616A617468616E67616D617269617070616E0D0A202A20547769747465723A2068747470733A2F2F747769747465722E636F6D2F746B61726B7576656C72616A610D0A202A20426C6F673A20687474703A2F2F6F7263';
wwv_flow_api.g_varchar2_table(6) := '6C6B696E672E626C6F6773706F742E636F6D2F0D0A202A205265666572656E63653A2068747470733A2F2F7777772E77337363686F6F6C732E636F6D2F686F77746F2F686F77746F5F6A735F736C69646573686F772E6173700D0A202A2F0D0A200D0A2A';
wwv_flow_api.g_varchar2_table(7) := '207B0D0A09626F782D73697A696E673A20626F726465722D626F783B0D0A7D0D0A0D0A626F6479207B0D0A09666F6E742D66616D696C793A2056657264616E612C2073616E732D73657269663B0D0A7D0D0A0D0A2E6D79536C69646573207B0D0A096469';
wwv_flow_api.g_varchar2_table(8) := '73706C61793A206E6F6E653B0D0A7D0D0A0D0A696D67207B0D0A09766572746963616C2D616C69676E3A206D6964646C653B0D0A7D0D0A0D0A0D0A2F2A20536C69646573686F7720636F6E7461696E6572202A2F0D0A0D0A2E736C69646573686F772D63';
wwv_flow_api.g_varchar2_table(9) := '6F6E7461696E6572207B0D0A096D61782D77696474683A203130303070783B0D0A09706F736974696F6E3A2072656C61746976653B0D0A096D617267696E3A206175746F3B0D0A7D0D0A0D0A0D0A2F2A2043617074696F6E2074657874202A2F0D0A0D0A';
wwv_flow_api.g_varchar2_table(10) := '2E74657874207B0D0A09636F6C6F723A20236632663266323B0D0A09666F6E742D73697A653A20313570783B0D0A0970616464696E673A2038707820313270783B0D0A09706F736974696F6E3A206162736F6C7574653B0D0A09746F703A20303B0D0A09';
wwv_flow_api.g_varchar2_table(11) := '77696474683A20313030253B0D0A09746578742D616C69676E3A2063656E7465723B0D0A7D0D0A0D0A0D0A2F2A204E756D62657220746578742028312F6E29202A2F0D0A0D0A2E6E756D62657274657874207B0D0A09636F6C6F723A2023663266326632';
wwv_flow_api.g_varchar2_table(12) := '3B0D0A09666F6E742D73697A653A20313270783B0D0A0970616464696E673A2038707820313270783B0D0A09706F736974696F6E3A206162736F6C7574653B0D0A09746F703A20303B0D0A7D0D0A0D0A0D0A2F2A2054686520646F74732F62756C6C6574';
wwv_flow_api.g_varchar2_table(13) := '732F696E64696361746F7273202A2F0D0A0D0A2E646F74207B0D0A096865696768743A20313570783B0D0A0977696474683A20313570783B0D0A096D617267696E3A2030203270783B0D0A096261636B67726F756E642D636F6C6F723A20236262623B0D';
wwv_flow_api.g_varchar2_table(14) := '0A09626F726465722D7261646975733A203530253B0D0A09646973706C61793A20696E6C696E652D626C6F636B3B0D0A097472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E367320656173653B0D0A7D0D0A0D0A2E61637469';
wwv_flow_api.g_varchar2_table(15) := '7665207B0D0A096261636B67726F756E642D636F6C6F723A20233731373137313B0D0A7D0D0A0D0A0D0A2F2A20466164696E6720616E696D6174696F6E202A2F0D0A0D0A2E66616465207B0D0A092D7765626B69742D616E696D6174696F6E2D6E616D65';
wwv_flow_api.g_varchar2_table(16) := '3A20666164653B0D0A092D7765626B69742D616E696D6174696F6E2D6475726174696F6E3A20312E35733B0D0A09616E696D6174696F6E2D6E616D653A20666164653B0D0A09616E696D6174696F6E2D6475726174696F6E3A20312E35733B0D0A7D0D0A';
wwv_flow_api.g_varchar2_table(17) := '0D0A402D7765626B69742D6B65796672616D65732066616465207B0D0A0966726F6D207B0D0A09096F7061636974793A202E340D0A097D0D0A09746F207B0D0A09096F7061636974793A20310D0A097D0D0A7D0D0A0D0A406B65796672616D6573206661';
wwv_flow_api.g_varchar2_table(18) := '6465207B0D0A0966726F6D207B0D0A09096F7061636974793A202E340D0A097D0D0A09746F207B0D0A09096F7061636974793A20310D0A097D0D0A7D0D0A0D0A0D0A2F2A204F6E20736D616C6C65722073637265656E732C206465637265617365207465';
wwv_flow_api.g_varchar2_table(19) := '78742073697A65202A2F0D0A0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20333030707829207B0D0A092E74657874207B0D0A0909666F6E742D73697A653A20313170780D0A097D0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(169878629313329994)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_file_name=>'slideshowautomatic.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '2F2A0D0A202A204F7261636C65204150455820536C69646573686F772E0D0A202A20506C75672D696E20547970653A20526567696F6E0D0A202A2053756D6D6172793A204120706C7567696E20746F20646973706C617920696D61676573206173206120';
wwv_flow_api.g_varchar2_table(2) := '726573706F6E7369766520736C69646573686F772E0D0A202A0D0A202A202D2D2D2D2D20436F6E7461637420696E666F726D6174696F6E202D2D2D2D0D0A202A0D0A202A20446576656C6F706564206279202A204576616C7561746520436F6E73756C74';
wwv_flow_api.g_varchar2_table(3) := '696E672053657276696365732C2042616E67616C6F72650D0A202A20436F6E746163743A20696E666F406576616C7561746563732E636F6D0D0A202A20576562736974653A2068747470733A2F2F6576616C7561746563732E636F6D0D0A202A0D0A202A';
wwv_flow_api.g_varchar2_table(4) := '2040617574686F72204B61726B7576656C72616A61205468616E67616D617269617070616E202D20746B61726B7576656C72616A6140676D61696C2E636F6D0D0A202A2050726F66696C653A2068747470733A2F2F7777772E6C696E6B6564696E2E636F';
wwv_flow_api.g_varchar2_table(5) := '6D2F696E2F6B61726B7576656C72616A617468616E67616D617269617070616E0D0A202A20547769747465723A2068747470733A2F2F747769747465722E636F6D2F746B61726B7576656C72616A610D0A202A20426C6F673A20687474703A2F2F6F7263';
wwv_flow_api.g_varchar2_table(6) := '6C6B696E672E626C6F6773706F742E636F6D2F0D0A202A205265666572656E63653A2068747470733A2F2F7777772E77337363686F6F6C732E636F6D2F686F77746F2F686F77746F5F6A735F736C69646573686F772E6173700D0A202A2F0D0A0D0A2A20';
wwv_flow_api.g_varchar2_table(7) := '7B0D0A09626F782D73697A696E673A20626F726465722D626F780D0A7D0D0A0D0A626F6479207B0D0A09666F6E742D66616D696C793A2056657264616E612C2073616E732D73657269663B0D0A096D617267696E3A20300D0A7D0D0A0D0A2E6D79536C69';
wwv_flow_api.g_varchar2_table(8) := '646573207B0D0A09646973706C61793A206E6F6E650D0A7D0D0A0D0A696D67207B0D0A09766572746963616C2D616C69676E3A206D6964646C653B0D0A7D0D0A0D0A0D0A2F2A20536C69646573686F7720636F6E7461696E6572202A2F0D0A0D0A2E736C';
wwv_flow_api.g_varchar2_table(9) := '69646573686F772D636F6E7461696E6572207B0D0A096D61782D77696474683A203130303070783B0D0A09706F736974696F6E3A2072656C61746976653B0D0A096D617267696E3A206175746F3B0D0A7D0D0A0D0A0D0A2F2A204E657874202620707265';
wwv_flow_api.g_varchar2_table(10) := '76696F757320627574746F6E73202A2F0D0A0D0A2E707265762C0D0A2E6E657874207B0D0A09637572736F723A20706F696E7465723B0D0A09706F736974696F6E3A206162736F6C7574653B0D0A09746F703A203530253B0D0A0977696474683A206175';
wwv_flow_api.g_varchar2_table(11) := '746F3B0D0A0970616464696E673A20313670783B0D0A096D617267696E2D746F703A202D323270783B0D0A09636F6C6F723A2077686974653B0D0A09666F6E742D7765696768743A20626F6C643B0D0A09666F6E742D73697A653A20313870783B0D0A09';
wwv_flow_api.g_varchar2_table(12) := '7472616E736974696F6E3A20302E367320656173653B0D0A09626F726465722D7261646975733A2030203370782033707820303B0D0A09757365722D73656C6563743A206E6F6E653B0D0A7D0D0A0D0A0D0A2F2A20506F736974696F6E2074686520226E';
wwv_flow_api.g_varchar2_table(13) := '65787420627574746F6E2220746F20746865207269676874202A2F0D0A0D0A2E6E657874207B0D0A0972696768743A20303B0D0A09626F726465722D7261646975733A2033707820302030203370783B0D0A7D0D0A0D0A0D0A2F2A204F6E20686F766572';
wwv_flow_api.g_varchar2_table(14) := '2C20616464206120626C61636B206261636B67726F756E6420636F6C6F7220776974682061206C6974746C6520626974207365652D7468726F756768202A2F0D0A0D0A2E707265763A686F7665722C0D0A2E6E6578743A686F766572207B0D0A09626163';
wwv_flow_api.g_varchar2_table(15) := '6B67726F756E642D636F6C6F723A207267626128302C20302C20302C20302E38293B0D0A7D0D0A0D0A0D0A2F2A2043617074696F6E2074657874202A2F0D0A0D0A2E74657874207B0D0A09636F6C6F723A20236632663266323B0D0A09666F6E742D7369';
wwv_flow_api.g_varchar2_table(16) := '7A653A20313570783B0D0A0970616464696E673A2038707820313270783B0D0A09706F736974696F6E3A206162736F6C7574653B0D0A09746F703A20303B0D0A0977696474683A20313030253B0D0A09746578742D616C69676E3A2063656E7465723B0D';
wwv_flow_api.g_varchar2_table(17) := '0A7D0D0A0D0A0D0A2F2A204E756D62657220746578742028312F6E29202A2F0D0A0D0A2E6E756D62657274657874207B0D0A09636F6C6F723A20236632663266323B0D0A09666F6E742D73697A653A20313270783B0D0A0970616464696E673A20387078';
wwv_flow_api.g_varchar2_table(18) := '20313270783B0D0A09706F736974696F6E3A206162736F6C7574653B0D0A09746F703A20303B0D0A7D0D0A0D0A0D0A2F2A2054686520646F74732F62756C6C6574732F696E64696361746F7273202A2F0D0A0D0A2E646F74207B0D0A09637572736F723A';
wwv_flow_api.g_varchar2_table(19) := '20706F696E7465723B0D0A096865696768743A20313570783B0D0A0977696474683A20313570783B0D0A096D617267696E3A2030203270783B0D0A096261636B67726F756E642D636F6C6F723A20236262623B0D0A09626F726465722D7261646975733A';
wwv_flow_api.g_varchar2_table(20) := '203530253B0D0A09646973706C61793A20696E6C696E652D626C6F636B3B0D0A097472616E736974696F6E3A206261636B67726F756E642D636F6C6F7220302E367320656173653B0D0A7D0D0A0D0A2E6163746976652C0D0A2E646F743A686F76657220';
wwv_flow_api.g_varchar2_table(21) := '7B0D0A096261636B67726F756E642D636F6C6F723A20233731373137313B0D0A7D0D0A0D0A0D0A2F2A20466164696E6720616E696D6174696F6E202A2F0D0A0D0A2E66616465207B0D0A092D7765626B69742D616E696D6174696F6E2D6E616D653A2066';
wwv_flow_api.g_varchar2_table(22) := '6164653B0D0A092D7765626B69742D616E696D6174696F6E2D6475726174696F6E3A20312E35733B0D0A09616E696D6174696F6E2D6E616D653A20666164653B0D0A09616E696D6174696F6E2D6475726174696F6E3A20312E35733B0D0A7D0D0A0D0A40';
wwv_flow_api.g_varchar2_table(23) := '2D7765626B69742D6B65796672616D65732066616465207B0D0A0966726F6D207B0D0A09096F7061636974793A202E340D0A097D0D0A09746F207B0D0A09096F7061636974793A20310D0A097D0D0A7D0D0A0D0A406B65796672616D6573206661646520';
wwv_flow_api.g_varchar2_table(24) := '7B0D0A0966726F6D207B0D0A09096F7061636974793A202E340D0A097D0D0A09746F207B0D0A09096F7061636974793A20310D0A097D0D0A7D0D0A0D0A0D0A2F2A204F6E20736D616C6C65722073637265656E732C206465637265617365207465787420';
wwv_flow_api.g_varchar2_table(25) := '73697A65202A2F0D0A0D0A406D65646961206F6E6C792073637265656E20616E6420286D61782D77696474683A20333030707829207B0D0A092E707265762C0D0A092E6E6578742C0D0A092E74657874207B0D0A0909666F6E742D73697A653A20313170';
wwv_flow_api.g_varchar2_table(26) := '780D0A097D0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(169878988974330000)
,p_plugin_id=>wwv_flow_api.id(383634027351215608)
,p_file_name=>'slideshowmanual.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
