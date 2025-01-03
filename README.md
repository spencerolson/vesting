# Vesting

Calculates how much money you'll get, and when, based on vesting schedules.

## Getting Started

1. Add your grants to a `grants.json` file (see `grants.json.example` for example format. Note that the `start` date should be the "Vesting Commencement Date", NOT the first date that shares are awarded)

   ```bash
   cd vesting/
   touch grants.json
   ```

2. Adjust the `@price_per_unit` in `lib/vesting/grant.ex` as needed (defaults to $23.60)

3. Run the program

```bash
$ mix run -e Vesting.run
Jun 01, 2022: $181 (1 grant vesting)
Sep 01, 2022: $181 (1 grant vesting)
Dec 01, 2022: $181 (1 grant vesting)
Mar 01, 2023: $181 (1 grant vesting)
Jun 01, 2023: $854 (2 grants vesting)
Sep 01, 2023: $854 (2 grants vesting)
Dec 01, 2023: $854 (2 grants vesting)
Mar 01, 2024: $854 (2 grants vesting)
Jun 01, 2024: $854 (2 grants vesting)
Sep 01, 2024: $854 (2 grants vesting)
Dec 01, 2024: $854 (2 grants vesting)
Mar 01, 2025: $854 (2 grants vesting)
Jun 01, 2025: $854 (2 grants vesting)
Sep 01, 2025: $854 (2 grants vesting)
Dec 01, 2025: $854 (2 grants vesting)
Mar 01, 2026: $854 (2 grants vesting)
Jun 01, 2026: $673 (1 grant vesting)
Sep 01, 2026: $673 (1 grant vesting)
Dec 01, 2026: $673 (1 grant vesting)
Mar 01, 2027: $673 (1 grant vesting)
```
