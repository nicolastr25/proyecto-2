library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_freq2 is
  generic (N         : natural := 500000;        
           BUS_WIDTH : natural := 19);
  port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal clk_o   : out std_logic);
end divisor_freq2;

architecture structural of divisor_freq2 is

  signal clk_o_reg  : std_logic;
  signal clk_o_next : std_logic;
  signal q_reg      : unsigned(BUS_WIDTH-1 downto 0);
  signal q_next     : unsigned(BUS_WIDTH-1 downto 0);
  
begin

  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
	  clk_o_reg <= '0';
      q_reg <= (others => '0');
    elsif rising_edge(clk) then
	  clk_o_reg <= clk_o_next;
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(q_reg)
  begin
	if (q_reg = (N-1)) then
	  clk_o_next <= '1'; 
	  q_next <= (others => '0');
	else
      clk_o_next <= '0'; 	  
	  q_next <= q_reg + 1;
	end if; 	
  end process comb;
  
  clk_o <= clk_o_reg; 
  
end structural;