library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Blink is

	port(enable	:	in std_logic;
		  clk		:	in std_logic;
		  ledOut : out std_logic);

end Blink;

architecture Behavioral of Blink is

	signal s_blink	:	std_logic;

begin

	process(clk, enable)
		begin
		if(enable = '1') then
			if(rising_edge(clk))then		
				if(s_blink = '1') then
					ledOut <= '1';
					s_blink<= '0';
				else
					s_blink<= '1';
					ledOut <= '0';
				end if;
			end if;
		else
			s_blink<= '0';
			ledOut <= '0';	
		end if;
	end process;

end Behavioral;