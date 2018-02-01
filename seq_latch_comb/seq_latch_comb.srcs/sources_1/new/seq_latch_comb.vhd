----------------------------------------------------------------------------------
-- Company: N-bit shift register of sequence/latch/combination circuit
-- Engineer: gyttrium
-- 
-- Create Date: 02/01/2018 02:29:06 PM
-- Design Name: 
-- Module Name: seq_latch_comb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seq_latch_comb is
  Generic(
    N: integer range 2 to 7:=3
  );
  Port ( 
    reset: in STD_LOGIC;
    clk: in STD_LOGIC;
    en_seq: in STD_LOGIC;
    en_latch: in STD_LOGIC;
    en_comb: in STD_LOGIC;
    d_seq: in STD_LOGIC;
    d_latch: in STD_LOGIC;
    d_comb: in STD_LOGIC;
    q_seq: out STD_LOGIC_VECTOR(N-1 downto 0);
    q_latch: out STD_LOGIC_VECTOR(N-1 downto 0);
    q_comb: out STD_LOGIC_VECTOR(N-1 downto 0)
  );
end seq_latch_comb;

architecture Behavioral of seq_latch_comb is

signal reg_latch: STD_LOGIC_VECTOR(N-1 downto 0);
signal reg_seq: STD_LOGIC_VECTOR(N-1 downto 0);
signal reg_comb: STD_LOGIC_VECTOR(N-1 downto 0);

begin


-- latch circuit
process(reset,en_latch,d_latch)
begin 
if(reset='1') then
    reg_latch <= (others=>'0');
elsif(en_latch='1') then
    reg_latch(N-1 downto 1) <= reg_latch(N-2 downto 0);
    reg_latch(0) <= d_latch;
end if;
q_latch <= reg_latch;
end process;

-- combination circuit
process(reset,en_comb,d_comb)
begin
if(reset='1') then
    reg_comb <= (others=>'0');
elsif(en_comb='1') then
    reg_comb(N-1 downto 1) <= reg_comb(N-2 downto 0);
    reg_comb(0) <= d_comb;
else 
    reg_comb <= reg_comb;
end if;
q_comb <= reg_comb;
end process;

-- sequence circuit
process(reset,clk)
begin
if(clk'event and clk='1')then
    if(reset='1')then
        reg_seq<=(others=>'0');
    else
        if (en_seq='1')then
        reg_seq(N-1 downto 1) <= reg_seq(N-2 downto 0);
        reg_seq(0) <= d_seq;
        else 
        reg_seq<=reg_seq;
        end if;
    end if;
end if;
q_seq <= reg_seq;
end process;


end Behavioral;
