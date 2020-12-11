import pandas as pd
import sys

def main():
    df = pd.read_csv(sys.argv[1])
    df = df.rename(columns={"Name1": "ID", "Address1": "ADDRESS", "City": "CITY", "State": "STATE", "ZIP_Code":"ZIP"})
    df.to_csv("geo" + sys.argv[1], index = False)

if __name__ == '__main__':
    sys.exit(main())
