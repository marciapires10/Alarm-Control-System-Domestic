library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Bin2BCD is

	port(bin		: in	std_logic_vector(4 downto 0);
		  bcd0	: out	std_logic_vector(3 downto 0);
		  bcd1   : out std_logic_vector(3 downto 0));
		  
end Bin2BCD;

architecture Behavioral of Bin2BCD is

	signal s_bin		: integer;
	signal s_tens		: integer;
	signal s_units		: integer;

begin

	s_bin <= to_integer(unsigned(bin));
	
	s_tens		<= (s_bin / 10) mod 10;
	s_units		<= s_bin mod 10;
	
	bcd0 <= std_logic_vector(to_unsigned(s_tens, 4));
	bcd1 <= std_logic_vector(to_unsigned(s_units, 4));

end Behavioral;