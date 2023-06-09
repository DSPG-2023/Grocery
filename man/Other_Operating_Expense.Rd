% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Other_Operating_Expense.R
\name{Other_Operating_Expense}
\alias{Other_Operating_Expense}
\title{Calculates the Estimated Cost of Miscellaneous Expenses for Grocery Stores}
\usage{
Other_Operating_Expense(Total_Estimated_Revenue, Percentage = 0.1088)
}
\arguments{
\item{Total_Estimated_Revenue}{Total estimated revenue based on market size/location.}

\item{Percentage}{Percentage of total estimated revenue spent on miscellaneous
("other") operating expenses selected via user input (defaults to the average
percentage taken from Bizminer and Vertical IQ).}
}
\value{
The output returns the estimated dollar amount spent on these other expenses for
a hypothetical grocery store in a given location.
}
\description{
This function calculates the estimated cost of miscellaneous expenses for a
hypothetical store in a user-selected location based off of a user-selected percentage
parameter. If not specified by the user, this percentage defaults to the industry average
taken from Bizminer and Vertical IQ. These expenses include tax, administrative
and repair costs, among others.
}
\details{
This function employs a default average percentage value from the financial analysis
and market research firms Bizminer and Vertical IQ and is based upon
calculations originally formulated by FFED ISU Extension and Outreach.
}
\author{
Aaron Null
}
