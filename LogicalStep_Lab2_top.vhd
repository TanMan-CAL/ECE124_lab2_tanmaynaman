-- Members: Naman Biyani and Tanmay Shah
-- LS206_T20_LAB2

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- top-level entity declaration 
entity LogicalStep_Lab2_top is 
  port (
    clkin_50         : in std_logic;                     
    pb_n             : in std_logic_vector(3 downto 0);  -- push-button inputs (default active low)
    sw               : in std_logic_vector(7 downto 0);  -- 8-bit switch inputs for user control
    leds             : out std_logic_vector(7 downto 0); -- output to LEDs for display
    seg7_data        : out std_logic_vector(6 downto 0); -- output to 7-segment display
    seg7_char1       : out std_logic;                    -- selector for the first 7-segment digit
    seg7_char2       : out std_logic                     -- selector for the second 7-segment digit
  ); 
end LogicalStep_Lab2_top;

-- architecture definition for the top-level
architecture SimpleCircuit of LogicalStep_Lab2_top is

  -- component declarations follow
  
  -- seven-segment display component
  component SevenSegment port (
    hex      : in std_logic_vector(3 downto 0);          -- 4-bit data to display
    sevenseg : out std_logic_vector(6 downto 0)          -- 7-segment display output
  ); 
  end component;
  
  -- multiplexer for switching between two 7-segment display inputs
  component segment7_mux port (
    clk    : in std_logic := '0';                        -- Clock input
    DIN2   : in std_logic_vector(6 downto 0);            -- second digit
    DIN1   : in std_logic_vector(6 downto 0);            -- first digit
    DOUT   : out std_logic_vector(6 downto 0);           -- output to 7-segment display
    DIG2   : out std_logic;                              -- selector for second digit
    DIG1   : out std_logic                               -- selector for first digit
  );
  end component;
  
  -- logic multiplexer for switching between two 4-bit inputs
  component logic_mux port (
    logic_in0, logic_in1 : in std_logic_vector(3 downto 0); -- input
    logic_select         : in std_logic_vector(1 downto 0); -- select signal
    logic_out            : out std_logic_vector(3 downto 0) -- ouput
  );
  end component;
  
  -- special component for adding/non-adding output based on select signal
  component special_com port (
    logic_num0, logic_num1 : in std_logic_vector(3 downto 0); -- inputs
    logic_select2          : in std_logic;                    -- single-bit select signal
    logic_out2             : out std_logic_vector(3 downto 0) -- output
  );
  end component;

  -- component to invert push-button inputs (converting active-low to active-high)
  component PB_Inverters port (
    pb_n : in std_logic_vector(3 downto 0);                  -- active-low push buttons
    pb   : out std_logic_vector(3 downto 0)                  -- inverted (active-high) push buttons
  );
  end component;

  -- 4-bit full adder component for adding two 4-bit numbers
  component full_adder_4bit port (
    BUS0_b3, BUS1_b3, BUS0_b2, BUS1_b2, BUS0_b1, BUS1_b1, BUS0_b0, BUS1_b0 : in std_logic; -- bit-wise inputs
    Carry_In     : in std_logic;                                            -- carry input
    Carry_Out3   : out std_logic;                                           -- carry output
    SUM          : out std_logic_vector(3 downto 0)                         -- 4-bit sum output
  );
  end component;

  -- signals for intermediate storage and data transfer
  signal seg7_A               : std_logic_vector(6 downto 0);  -- Seven-segment data for Operand A
  signal seg7_B               : std_logic_vector(6 downto 0);  -- seven-segment data for Operand B

  signal hex_A                : std_logic_vector(3 downto 0);  -- 4-bit input A
  signal hex_B                : std_logic_vector(3 downto 0);  -- 4-bit input B

  signal pb                   : std_logic_vector(3 downto 0);  -- inverted push-button inputs

  signal full_adder_4bit_hex_sum : std_logic_vector(3 downto 0); -- 4-bit sum from full adder
  signal Carry_Out3_Remainder : std_logic;                      -- carry-out signal
  signal Carry_Out3_Concat    : std_logic_vector(3 downto 0);    -- concatenated carry-out signal

  signal Operand_A            : std_logic_vector(3 downto 0);    -- for display
  signal Operand_B            : std_logic_vector(3 downto 0);    -- for display

begin
  -- assign switches to hex_A and hex_B
  hex_A <= sw(3 downto 0);  -- lower 4 switches for Operand A
  hex_B <= sw(7 downto 4);  -- Upper 4 switches for Operand B

  -- concatenate carry-out signal with "000"
  Carry_Out3_Concat <= "000" & Carry_Out3_Remainder;

  -- STRUCTURAL VHDL: component instantiations

  -- a 4-bit full adder
INST0: full_adder_4bit port map (
  hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0),
  '0', Carry_Out3_Remainder, full_adder_4bit_hex_sum
);

-- 7-segment display to show Operand A
INST1: SevenSegment port map (Operand_A, seg7_A);
-- 7-segment display to show Operand B
INST2: SevenSegment port map (Operand_B, seg7_B);

-- multiplexer to alternate between two 7-segment displays
INST3: segment7_mux port map (
  clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1
);

-- push-button signal inverters
INST4: PB_Inverters port map(pb_n, pb);

-- multiplexer to display a logic operation on the LEDs
INST5: logic_mux port map(
  hex_A, hex_B, pb(1 downto 0), leds(3 downto 0)
);
INST6: special_com port map(
  hex_B, Carry_Out3_Concat, pb(2), Operand_B
);
INST7: special_com port map(
  hex_A, full_adder_4bit_hex_sum, pb(2), Operand_A
);
end SimpleCircuit;
