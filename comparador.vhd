library ieee;
use ieee.std_logic_1164.all;

entity comparador is
	generic(
		n: integer := 6
	);
	port(
		a : in std_logic_vector(n-1 downto 0);
		b : in std_logic_vector(n-1 downto 0);
		eq : out std_logic
	);
end comparador;

architecture modular of comparador is
begin
	eq <= '1' when a = b else
			'0';
end modular;