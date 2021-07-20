library ieee;
use ieee.std_logic_1164.all;

entity reg_d is
	port(
		reset_n, clk: in std_logic;
		d: in std_logic_vector(3 downto 0);
		q: out std_logic_vector(3 downto 0));
		
end reg_d;

architecture conc of reg_d is

begin
	
	process(clk, reset_n, d)
		begin
		
			if reset_n = '0' then
				q <= "0000";
			elsif rising_edge(clk) then
				q <= d;
				
		end if;
	end process;
	
end conc;