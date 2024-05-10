module bram(
	input clkA,
	input clkB,

	input enA,
    input enB,

    input [3:0] wenA,
    input [3:0] wenB,

    input [31:0] data_inA,
    input [31:0] data_inB,

    input [14:0] addrA,
    input [14:0] addrB,

    output [31:0] data_outA,
    output [31:0] data_outB
);

RAMB36E1 #(
	// Address Collision Mode: "PERFORMANCE" or "DELAYED_WRITE"
	.RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
	// Collision check: Values ("ALL", "WARNING_ONLY", "GENERATE_X_ONLY" or "NONE")
	.SIM_COLLISION_CHECK("ALL"),
	// DOA_REG, DOB_REG: Optional output register (0 or 1)
	.DOA_REG(1),
	.DOB_REG(1),
	.EN_ECC_READ("FALSE"), // Enable ECC decoder,
	// FALSE, TRUE
	.EN_ECC_WRITE("FALSE"), // Enable ECC encoder,
	// FALSE, TRUE
	// INITP_00 to INITP_0F: Initial contents of the parity memory array
	//.INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
	// INIT_00 to INIT_7F: Initial contents of the data memory array
	.INIT_00(256'h0000507100000000000000000000000000000000000000000000642500002597),
	.INIT_02(256'h0000000000000000000000000000000000000000000000000000000000008CF5),

	// INIT_A, INIT_B: Initial values on output ports
	.INIT_A(36'h000000000),
	.INIT_B(36'h000000000),
	// Initialization File: RAM initialization file
	.INIT_FILE("NONE"),
	// RAM Mode: "SDP" or "TDP"
	.RAM_MODE("TDP"),
	// RAM_EXTENSION_A, RAM_EXTENSION_B: Selects cascade mode ("UPPER", "LOWER", or "NONE")
	.RAM_EXTENSION_A("NONE"),
	.RAM_EXTENSION_B("NONE"),
	// READ_WIDTH_A/B, WRITE_WIDTH_A/B: Read/write width per port
	.READ_WIDTH_A(36), // 0-72
	.READ_WIDTH_B(36), // 0-36
	.WRITE_WIDTH_A(36), // 0-36
	.WRITE_WIDTH_B(36), // 0-72
	// RSTREG_PRIORITY_A, RSTREG_PRIORITY_B: Reset or enable priority ("RSTREG" or "REGCE")
	.RSTREG_PRIORITY_A("RSTREG"),
	.RSTREG_PRIORITY_B("RSTREG"),
	// SRVAL_A, SRVAL_B: Set/reset value for output
	.SRVAL_A(36'h000000000),
	.SRVAL_B(36'h000000000),
	// Simulation Device: Must be set to "7SERIES" for simulation behavior
	.SIM_DEVICE("7SERIES"),
	// WriteMode: Value on output upon a write ("WRITE_FIRST", "READ_FIRST", or "NO_CHANGE")
	.WRITE_MODE_A("WRITE_FIRST"),
	.WRITE_MODE_B("WRITE_FIRST")
	)
	RAMB36E1_inst (
	// Cascade Signals: 1-bit (each) output: BRAM cascade ports (to create 64kx1)
	.CASCADEOUTA(), // 1-bit output: A port cascade
	.CASCADEOUTB(), // 1-bit output: B port cascade
	// ECC Signals: 1-bit (each) output: Error Correction Circuitry ports
	.DBITERR(), // 1-bit output: Double bit error status
	.ECCPARITY(), // 8-bit output: Generated error correction parity
	.RDADDRECC(), // 9-bit output: ECC read address
	.SBITERR(), // 1-bit output: Single bit error status
	// Port A Data: 32-bit (each) output: Port A data
	.DOADO(data_outA), // 32-bit output: A port data/LSB data
	.DOPADOP(), // 4-bit output: A port parity/LSB parity
	// Port B Data: 32-bit (each) output: Port B data
	.DOBDO(data_outB), // 32-bit output: B port data/MSB data
	.DOPBDOP(), // 4-bit output: B port parity/MSB parity
	// Cascade Signals: 1-bit (each) input: BRAM cascade ports (to create 64kx1)
	.CASCADEINA(), // 1-bit input: A port cascade
	.CASCADEINB(), // 1-bit input: B port cascade
	// ECC Signals: 1-bit (each) input: Error Correction Circuitry ports
	.INJECTDBITERR(), // 1-bit input: Inject a double bit error
	.INJECTSBITERR(), // 1-bit input: Inject a single bit error
	// Port A Address/Control Signals: 16-bit (each) input: Port A address and control signals (read port
	// when RAM_MODE="SDP")
	.ADDRARDADDR({1'b0,addrA[11:0],3'd0}), // 16-bit inp  ut: A port address/Read address
	.CLKARDCLK(clkA), // 1-bit input: A port clock/Read clock
	.ENARDEN(enA), // 1-bit input: A port enable/Read enable
	.REGCEAREGCE(1'b1), // 1-bit input: A port register enable/Register enable
	.RSTRAMARSTRAM(), // 1-bit input: A port set/reset
	.RSTREGARSTREG(), // 1-bit input: A port register set/reset
	.WEA(wenA), // 4-bit input: A port write enable
	// Port A Data: 32-bit (each) input: Port A data
	.DIADI(data_inA), // 32-bit input: A port data/LSB data
	.DIPADIP(), // 4-bit input: A port parity/LSB parity
	// Port B Address/Control Signals: 16-bit (each) input: Port B address and control signals (write port
	// when RAM_MODE="SDP")
	.ADDRBWRADDR({1'b0,addrB[11:0],3'd0}), // 16-bit input: B port address/Write address
	.CLKBWRCLK(clkB), // 1-bit input: B port clock/Write clock
	.ENBWREN(enB), // 1-bit input: B port enable/Write enable
	.REGCEB(1'b1), // 1-bit input: B port register enable
	.RSTRAMB(), // 1-bit input: B port set/reset
	.RSTREGB(), // 1-bit input: B port register set/reset
	.WEBWE({4'd0,wenB}), // 8-bit input: B port write enable/Write enable
	// Port B Data: 32-bit (each) input: Port B data
	.DIBDI(data_inB), // 32-bit input: B port data/MSB data
	.DIPBDIP() // 4-bit input: B port parity/MSB parity
);
// End of RAMB36E1_inst instantiation

endmodule