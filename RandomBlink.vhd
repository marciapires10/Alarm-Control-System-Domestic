library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RandomBlink is
    port (clk : in  std_logic; 
			 rst : in  std_logic; 
          DB : out  std_logic_vector (17 downto 0));
end RandomBlink;

architecture Behavioral of RandomBlink is

signal count : std_logic_vector (24 downto 0); 
signal state : std_logic_vector (17 downto 0); 

begin
process (clk, rst, state) is begin  
   if rst = '0' then					 
		count <= (others => '0');	 
      DB <= (others => '0');		 
		state <= (others => '0');	 
   elsif (rising_edge(clk)) then	 
		count <= count + 1;			 
      if(count = 25000000) then	 
			state <= not state;		 
			count <= (others => '0');
		end if;				
   end if;
	
	DB <= state;						 
end process;

end Behavioral;