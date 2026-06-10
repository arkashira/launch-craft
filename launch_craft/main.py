import argparse
import sys
from .utils import submit_product

def main(argv=None) -> None:
    parser = argparse.ArgumentParser(
        description="LaunchPal – submit your indie product for review."
    )
    parser.add_argument("name", help="Product name")
    parser.add_argument("description", help="Short description")
    args = parser.parse_args(argv)

    try:
        prod_id = submit_product(args.name, args.description)
        print(f"✅ Product submitted! ID: {prod_id}")
    except ValueError as exc:
        print(f"❌ Error: {exc}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()