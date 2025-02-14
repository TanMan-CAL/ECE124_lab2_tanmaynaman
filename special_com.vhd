library ieee;
use ieee.std_logic_1164.all;

-- defining the entity special_com: a 2 - 1 multiplexer entity
entity special_com is
	port (
		logic_num0, logic_num1 : in std_logic_vector(3 downto 0); -- 2 input 4 bit vector
		logic_select2 : in std_logic; -- bit for the multiplexer
		logic_out2 : out std_logic_vector(3 downto 0) -- output 4-bit logic vector
	);
end special_com;

-- architecture definition for 2-1 mux
architecture mux_logic of special_com is

begin
	-- 2 -1 multiplexer logic based on the push button selector
	with logic_select2 select
		logic_out2 <= logic_num0 when '0',  	-- logic_select2 is '0' then output logic_out2 gets the value of logic_num0	
			      logic_num1 when '1';	-- logic_select2 is '1' then output logic_out2 gets the value of logic_num1
end mux_logic;
