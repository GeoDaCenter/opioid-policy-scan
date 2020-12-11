import pandas as pd
import sys

def main():
    df = pd.read_csv(sys.argv[1])
    df = df.iloc[:, [0,3,6,7,8]]
    df = df.rename(columns={"Name1": "ID", "Address1": "ADDRESS", "City": "CITY", "State": "STATE", "ZIP_Code":"ZIP"})
    df.to_csv('/'.join(sys.argv[1].split('/')[:-1]) + "/geo" + sys.argv[1].split('/')[-1], index = False)

if __name__ == '__main__':
    sys.exit(main())
