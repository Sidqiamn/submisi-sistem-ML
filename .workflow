name: Preprocessing Workflow

on:
  push:
    branches:
      - main

jobs:
  preprocess:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: "3.9"

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install pandas scikit-learn

      - name: Run preprocessing script
        run: python preprocessing/Nama-siswa.py

      - name: Commit processed data
        run: |
          git config --global user.name 'GitHub Action'
          git config --global user.email 'action@github.com'
          git add dataset/processed/iris_processed.csv
          git commit -m "Update processed dataset"
          git push
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
