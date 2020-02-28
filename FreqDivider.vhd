library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FreqDivider is

	generic(N	  : 	  positive := 4);
	   port(clkIn : in  std_logic;
		     clkOut: out std_logic);
			  
end FreqDivider;

architecture Behavioral of FreqDivider is

	signal s_counter: natural;
	signal s_halfWay: natural;
	
begin

	s_halfWay <= N/2 - 1;
	
	process(clkIn)
	begin
			if(rising_edge(clkIn)) then
				if(s_counter = N - 1) then
					clkOut <= '0';
					s_counter <= 0;
				else
					if(s_counter = s_halfWay)  then
						clkOut <= '1';
					end if;
					s_counter <= s_counter + 1;
				end if;
			end if;
	end process;
	
end Behavioral;