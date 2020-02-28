library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegStates is
	port(alarmOn : in std_logic;
		  --sysArm : in std_logic;
		  alarmOff : in std_logic;
		  decOutput	:	out	std_logic_vector(6 downto 0));
end Bin7SegStates;

architecture Behavioral of Bin7SegStates is
begin

	decOutput <= "1111001" when (alarmOn = '1') else	--1
					 "0100100" when (alarmOff = '1') else	--2
					 --"0110000" when (sysArm = '1') else	--3
					 "0000000";											--OFF
	

end Behavioral;