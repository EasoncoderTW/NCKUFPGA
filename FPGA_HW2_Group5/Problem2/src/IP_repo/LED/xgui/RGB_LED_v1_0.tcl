# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_W" -parent ${Page_0}
  ipgui::add_param $IPINST -name "STEP" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIME_2MS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIME_2MS_W" -parent ${Page_0}


}

proc update_PARAM_VALUE.NUM { PARAM_VALUE.NUM } {
	# Procedure called to update NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM { PARAM_VALUE.NUM } {
	# Procedure called to validate NUM
	return true
}

proc update_PARAM_VALUE.NUM_W { PARAM_VALUE.NUM_W } {
	# Procedure called to update NUM_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_W { PARAM_VALUE.NUM_W } {
	# Procedure called to validate NUM_W
	return true
}

proc update_PARAM_VALUE.STEP { PARAM_VALUE.STEP } {
	# Procedure called to update STEP when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.STEP { PARAM_VALUE.STEP } {
	# Procedure called to validate STEP
	return true
}

proc update_PARAM_VALUE.TIME_2MS { PARAM_VALUE.TIME_2MS } {
	# Procedure called to update TIME_2MS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIME_2MS { PARAM_VALUE.TIME_2MS } {
	# Procedure called to validate TIME_2MS
	return true
}

proc update_PARAM_VALUE.TIME_2MS_W { PARAM_VALUE.TIME_2MS_W } {
	# Procedure called to update TIME_2MS_W when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIME_2MS_W { PARAM_VALUE.TIME_2MS_W } {
	# Procedure called to validate TIME_2MS_W
	return true
}

proc update_PARAM_VALUE.sBLUE { PARAM_VALUE.sBLUE } {
	# Procedure called to update sBLUE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sBLUE { PARAM_VALUE.sBLUE } {
	# Procedure called to validate sBLUE
	return true
}

proc update_PARAM_VALUE.sINDIGO { PARAM_VALUE.sINDIGO } {
	# Procedure called to update sINDIGO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sINDIGO { PARAM_VALUE.sINDIGO } {
	# Procedure called to validate sINDIGO
	return true
}

proc update_PARAM_VALUE.sORANGE { PARAM_VALUE.sORANGE } {
	# Procedure called to update sORANGE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sORANGE { PARAM_VALUE.sORANGE } {
	# Procedure called to validate sORANGE
	return true
}

proc update_PARAM_VALUE.sPURPLE { PARAM_VALUE.sPURPLE } {
	# Procedure called to update sPURPLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sPURPLE { PARAM_VALUE.sPURPLE } {
	# Procedure called to validate sPURPLE
	return true
}

proc update_PARAM_VALUE.sRED { PARAM_VALUE.sRED } {
	# Procedure called to update sRED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sRED { PARAM_VALUE.sRED } {
	# Procedure called to validate sRED
	return true
}

proc update_PARAM_VALUE.sYELLOW { PARAM_VALUE.sYELLOW } {
	# Procedure called to update sYELLOW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.sYELLOW { PARAM_VALUE.sYELLOW } {
	# Procedure called to validate sYELLOW
	return true
}


proc update_MODELPARAM_VALUE.TIME_2MS { MODELPARAM_VALUE.TIME_2MS PARAM_VALUE.TIME_2MS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIME_2MS}] ${MODELPARAM_VALUE.TIME_2MS}
}

proc update_MODELPARAM_VALUE.TIME_2MS_W { MODELPARAM_VALUE.TIME_2MS_W PARAM_VALUE.TIME_2MS_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIME_2MS_W}] ${MODELPARAM_VALUE.TIME_2MS_W}
}

proc update_MODELPARAM_VALUE.NUM { MODELPARAM_VALUE.NUM PARAM_VALUE.NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM}] ${MODELPARAM_VALUE.NUM}
}

proc update_MODELPARAM_VALUE.NUM_W { MODELPARAM_VALUE.NUM_W PARAM_VALUE.NUM_W } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_W}] ${MODELPARAM_VALUE.NUM_W}
}

proc update_MODELPARAM_VALUE.STEP { MODELPARAM_VALUE.STEP PARAM_VALUE.STEP } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.STEP}] ${MODELPARAM_VALUE.STEP}
}

proc update_MODELPARAM_VALUE.sRED { MODELPARAM_VALUE.sRED PARAM_VALUE.sRED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sRED}] ${MODELPARAM_VALUE.sRED}
}

proc update_MODELPARAM_VALUE.sORANGE { MODELPARAM_VALUE.sORANGE PARAM_VALUE.sORANGE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sORANGE}] ${MODELPARAM_VALUE.sORANGE}
}

proc update_MODELPARAM_VALUE.sYELLOW { MODELPARAM_VALUE.sYELLOW PARAM_VALUE.sYELLOW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sYELLOW}] ${MODELPARAM_VALUE.sYELLOW}
}

proc update_MODELPARAM_VALUE.sBLUE { MODELPARAM_VALUE.sBLUE PARAM_VALUE.sBLUE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sBLUE}] ${MODELPARAM_VALUE.sBLUE}
}

proc update_MODELPARAM_VALUE.sINDIGO { MODELPARAM_VALUE.sINDIGO PARAM_VALUE.sINDIGO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sINDIGO}] ${MODELPARAM_VALUE.sINDIGO}
}

proc update_MODELPARAM_VALUE.sPURPLE { MODELPARAM_VALUE.sPURPLE PARAM_VALUE.sPURPLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.sPURPLE}] ${MODELPARAM_VALUE.sPURPLE}
}

