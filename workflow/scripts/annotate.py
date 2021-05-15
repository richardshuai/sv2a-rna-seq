import pyensembl
import pandas as pd
import os

def main():
    dfs_to_annotate = ['results/diffexp/ko-vs-wt.diffexp.tsv', 'results/counts/all.tsv', 'results/counts/TMM_normalized.tsv']

    data = pyensembl.Genome(
        reference_name='GRCm38',
        annotation_name='mus_musculus',
        gtf_path_or_url='/home/rshuai/research/sv2a-rna-seq/resources/genome.gtf')
    data.index()

    for df_path in dfs_to_annotate:
        annotate(df_path, data)


def annotate(tsv_path, data):
    df = pd.read_table(tsv_path, sep='\t', index_col=0)
    df['gene_symbol'] = df.index
    df['gene_symbol'] = df['gene_symbol'].apply(lambda id: data.gene_by_id(id).gene_name)
    df.index = df['gene_symbol']
    df = df.drop('gene_symbol', axis=1)

    basename, ext = os.path.splitext(os.path.basename(tsv_path))
    parent_dir = os.path.dirname(tsv_path)
    df.to_csv(os.path.join(parent_dir, '{}_anno{}'.format(basename, ext)), sep='\t')


if __name__ == '__main__':
    main()