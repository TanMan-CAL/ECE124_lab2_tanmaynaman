-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port(
		clk				: in std_logic := '0';
		DIN2				: in std_logic_vector(6 downto 0);
		DIN1				: in std_logic_vector(6 downto 0);
		DOUT				: out std_logic_vector(6 downto 0);
		DIG2				: out std_logic;
		DIG1				: out std_logic
	);
	end component;
	
	component logic_mux port (
		logic_in0, logic_in1 : IN std_logic_vector(3 downto 0);
		logic_select : IN std_logic_vector(1 downto 0);
		logic_out : OUT std_logic_vector(3 downto 0)
	);
	end component;
	
	component special_com port (
		logic_num0, logic_num1 : in std_logic_vector(3 downto 0);
		logic_select2 : in std_logic;
		logic_out2 : out std_logic_vector(3 downto 0)
	);
	end component;
			
	component PB_Inverters port (
		pb_n : IN std_logic_vector(3 downto 0); 
		pb : OUT std_logic_vector(3 downto 0)
	);
	end component;
	
	component full_adder_4bit port (
		BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic;
		Carry_In : in std_logic;
		Carry_Out3 : out std_logic;
		SUM : out std_logic_vector(3 downto 0)
	);
	end component;
		
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--
	signal seg7_A		: std_logic_vector(6 downto 0);
	signal hex_B	   : std_logic_vector(3 downto 0);

	signal hex_A		: std_logic_vector(3 downto 0);
	signal seg7_B		: std_logic_vector(6 downto 0);
	
	signal pb : std_logic_vector(3 downto 0);
	signal full_adder_4bit_hex_sum : std_logic_vector(3 downto 0);
	
	signal Carry_Out3_Remainder : std_logic;
	signal Carry_Out3_Concat : std_logic_vector(3 downto 0);
	
	signal Operand_A : std_logic_vector(3 downto 0); -- hex_A
	signal Operand_B : std_logic_vector(3 downto 0); -- hex_B
	
		
-- Here the circuit begins

begin
	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);
	
	Carry_Out3_Concat <= "000" & Carry_Out3_Remainder;

--COMPONENT HOOKUP
--
-- generate the seven segment coding

	INST0: full_adder_4bit port map (hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0), '0', Carry_Out3_Remainder, full_adder_4bit_hex_sum);
	
   INST1: SevenSegment port map (Operand_A, seg7_A);
	INST2: SevenSegment port map (Operand_B, seg7_B);
	
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1); -- lowk no clue if this order is right aha.
	INST4: PB_Inverters port map(pb_n, pb);
	INST5: logic_mux port map(hex_A, hex_B, pb(1 downto 0), leds(3 downto 0));
	
	INST6: special_com port map(hex_B, Carry_Out3_Concat, pb(2), Operand_B);
	INST7: special_com port map(hex_A, full_adder_4bit_hex_sum, pb(2), Operand_A);
	
 
end SimpleCircuit;

