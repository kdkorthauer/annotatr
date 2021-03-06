% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/visualize.R
\name{plot_numerical_coannotations}
\alias{plot_numerical_coannotations}
\title{Plot numerical data occurring in pairs of annotations}
\usage{
plot_numerical_coannotations(annotated_regions, x, y, annot1, annot2,
  bin_width = 10, plot_title, x_label, y_label, legend_facet_label,
  legend_cum_label, quiet = FALSE)
}
\arguments{
\item{annotated_regions}{A \code{GRanges} returned from \code{annotate_regions()}.}

\item{x}{A string indicating the column of the \code{GRanges} to use for the x-axis.}

\item{y}{A string indicating the column of the \code{GRanges} to use for the y-axis. If missing, a histogram over \code{x} will be plotted. If not missing, a scatterplot is plotted.}

\item{annot1}{A string indicating the first annotation type.}

\item{annot2}{A string indicating the second annotation type.}

\item{bin_width}{An integer indicating the bin width of the histogram used for score. Default 10. Select something appropriate for the data. NOTE: This is only used if \code{y} is \code{NULL}.}

\item{plot_title}{A string used for the title of the plot. If missing, no title is displayed.}

\item{x_label}{A string used for the x-axis label. If missing, no x-axis label is displayed.}

\item{y_label}{A string used for the y-axis label. If missing, no y-axis label is displayed.}

\item{legend_facet_label}{A string used to label the gray bar portion of the legend. Defaults to "x in annot pair".}

\item{legend_cum_label}{A string used to label the red outline portion of the legend. Defaults to "All x".}

\item{quiet}{Print progress messages (FALSE) or not (TRUE).}
}
\value{
A \code{ggplot} object which can be viewed by calling it, or saved with \code{ggplot2::ggsave}.
}
\description{
Plot numerical data associated with regions occurring in \code{annot1}, \code{annot2} and in both. As with \code{plot_numerical()}, the result is a plot of histograms or x-y scatterplots.
}
\details{
For example, a CpG with associated percent methylation annotated to a CpG island and a promoter will count once in the All distribution and once in the CpG island / promoter facet distribution. However, a CpG associated only with a promoter will count once in the All distribution and once in the promoter / promoter distribution.
}
\examples{
   # Get premade CpG annotations
   data('annotations', package = 'annotatr')

   dm_file = system.file('extdata', 'IDH2mut_v_NBM_multi_data_chr9.txt.gz', package = 'annotatr')
   extraCols = c(diff_meth = 'numeric', mu1 = 'numeric', mu0 = 'numeric')
   dm_regions = read_regions(con = dm_file, extraCols = extraCols,
       rename_score = 'pval', rename_name = 'DM_status', format = 'bed')
   dm_regions = dm_regions[1:1000]

   dm_annots = annotate_regions(
       regions = dm_regions,
       annotations = annotations,
       ignore.strand = TRUE)

   dm_vs_num_co = plot_numerical_coannotations(
       annotated_regions = dm_annots,
       x = 'mu0',
       annot1 = 'hg19_cpg_islands',
       annot2 = 'hg19_cpg_shelves',
       bin_width = 5,
       plot_title = 'Group 0 Perc. Meth. in CpG Islands and Promoters',
       x_label = 'Percent Methylation')

}
