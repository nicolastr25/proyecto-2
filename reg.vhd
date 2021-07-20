Library ieee;
use ieee.std_logic_1164.all;

entity reg is 
  port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal d       :  in std_logic_vector(1 downto 0);  
		  signal en      :  in std_logic;
		  signal q       : out std_logic_vector(1 downto 0)); 
end reg;

architecture structural_0 of reg is


begin

  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
      q <= (others => '0');
    elsif rising_edge(clk) then
      if (en = '1') then
        q <= d;
      end if;
    end if;
  end process seq;

end structural_0;