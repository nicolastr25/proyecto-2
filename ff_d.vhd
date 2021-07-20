library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
	port(
			clk, reset_n, d: in std_logic;
		   q: out std_logic);
			
end ff_d;


architecture conc of ff_d is

begin

	process(reset_n, clk, d)
		begin
			if reset_n = '0' then
				q <= '0';
			elsif rising_edge(clk) then
				q <= d;
		end if;
	end process;

end conc;