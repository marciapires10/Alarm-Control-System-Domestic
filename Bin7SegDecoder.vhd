library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder is
	port(bcdInput	:	in		std_logic_vector(3 downto 0);
		  decOutput	:	out	std_logic_vector(6 downto 0));
end Bin7SegDecoder;

architecture Behavioral of Bin7SegDecoder is
begin

	decOutput <= "1111001" when (bcdInput = "0001") else	--1
					 "0100100" when (bcdInput = "0010") else	--2
					 "0110000" when (bcdInput = "0011") else	--3
					 "0011001" when (bcdInput = "0100") else	--4
					 "0010010" when (bcdInput = "0101") else	--5
					 "0000010" when (bcdInput = "0110") else	--6
					 "1111000" when (bcdInput = "0111") else	--7
					 "0000000" when (bcdInput = "1000") else	--8
					 "0010000" when (bcdInput = "1001") else	--9
					 "1000000" when (bcdInput = "0000") else	--0
					 "0000000";											--OFF

end Behavioral;