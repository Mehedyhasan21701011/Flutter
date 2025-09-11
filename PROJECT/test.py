import asyncio
from pyquotex.stable_api import Quotex

async def main():
    client = Quotex(
        email="quotexbroker366@gmail.com",
        password="mehedy&quotex7844",
        lang="en"
    )
    await client.connect()

    balance = await client.get_balance()
    print("Balance:", balance)

    await client.close()

asyncio.run(main())
