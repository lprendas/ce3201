import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_addition(dut):
    dut.a.value = 5
    dut.b.value = 3
    await Timer(1, units="ns")
    assert dut.sum.value == 8
