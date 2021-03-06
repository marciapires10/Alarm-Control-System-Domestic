library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Shell_Tb is
end Shell_Tb;

architecture Stimulus of Shell_Tb is

	signal s_sw : std_logic_vector(17 downto 0);
	signal s_clk : std_logic;
	signal r_led : std_logic_vector(17 downto 0);
	signal g_led : std_logic_vector(9 downto 0);
	signal hex0, hex4, hex5, hex6, hex7 : std_logic_vector(6 downto 0);
	
begin

	uut : entity work.Shell(Shell)
			port map(SW => s_sw,
						CLOCK_50 => s_clk,
						LEDG => g_led,
						LEDR => r_led,
						HEX0 => hex0,
						HEX4 => hex4,
						HEX5 => hex5,
						HEX6 => hex6,
						HEX7 => hex7);
						
	clock_proc : process
	begin
		
		s_clk <= '1'; wait for 100ns;
		s_clk <= '0'; wait for 100ns;
	end process;
						
	stim_proc : process
	
	begin
	
		wait for 100ns;
		s_sw(17) <= '1'; -- botão de pânico pressionado
		
		wait for 200ns;
		s_sw(17) <= '0'; 
		
		wait for 100ns;
		s_sw(16) <= '1'; -- alarme armado
		
		wait for 200ns;
		s_sw(11) <= '1';
		s_sw(10) <= '1';
		s_sw(9) <= '1'; -- código correto
		
		wait for 200ns;
		s_sw(16) <= '0'; -- alarme desarmado
		
		wait for 100ns;
		s_sw(16) <= '1'; -- alarme armado
		
		wait for 200ns;
		s_sw(5) <= '1'; -- sensor de interior ativo
		
		wait for 100ns;
		s_sw(3) <= '1'; -- sensor de janela ativo
		
		wait for 200ns;
		
	end process;
	
end Stimulus;