%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Developer CV
% LaTeX Class
% Version 2.0 (12/10/23)
%
% This class originates from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Omar Roldan
% Based on a template by  Jan Vorisek (jan@vorisek.me)
% Based on a template by Jan Küster (info@jankuester.com)
% Modified for LaTeX Templates by Vel (vel@LaTeXTemplates.com)
%
% License:
% The MIT License (see included LICENSE file)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{developercv}[2023/10/12 Developer CV Class v2.0]

%----------------------------------------------------------------------------------------
%   CLASS CONFIGURATION
%----------------------------------------------------------------------------------------

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} % Pass through any options to the base class
\ProcessOptions\relax % Process given options

\LoadClass{article} % Load the base class

%----------------------------------------------------------------------------------------
%   REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage[T1]{fontenc} % Output font encoding for international characters
\RequirePackage{xcolor} % Required for colors
\RequirePackage{tikz} % Required for drawing the colored boxes
\RequirePackage{ifthen} % Required for if-then-else statements
\RequirePackage{pgffor} % Required for the \foreach command
\RequirePackage{enumitem} % Required for list manipulation
\RequirePackage{hyperref} % Required for links
\RequirePackage{multicol} % Required for multiple columns
\RequirePackage{setspace} % Required for line spacing
% Geometry package will be loaded by Quarto

%----------------------------------------------------------------------------------------
%   COLOR DEFINITIONS
%----------------------------------------------------------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{mainblue}{HTML}{0E5484}
\definecolor{maingray}{HTML}{B9B9B9}

%----------------------------------------------------------------------------------------
%   MARGINS AND OTHER FORMATTING PARAMETERS
%----------------------------------------------------------------------------------------

\setlength{\parindent}{0pt} % Remove paragraph indentation
\setlength{\columnsep}{0.55cm} % Distance between the two columns of content
\setlength{\fboxrule}{0.75pt} % Width of the border around the overview

% Define colors for experience categories
\definecolor{experiencecolor}{HTML}{0E5484}
\definecolor{educationcolor}{HTML}{0E5484}
\definecolor{participationcolor}{HTML}{0E5484}

%----------------------------------------------------------------------------------------
%   SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newlength{\TotalSectionLength} % Define a new length to hold the remaining line width after the section title is printed
\newlength{\SectionTitleLength} % Define a new length to hold the width of the section title
\newcommand{\profilesection}[1]{%
  \setlength\TotalSectionLength{\linewidth}% Set the total line width
  \settowidth{\SectionTitleLength}{\huge #1 }% Calculate the width of the section title
  \addtolength\TotalSectionLength{-\SectionTitleLength}% Subtract the section title width from the total width
  \addtolength\TotalSectionLength{-2.22221pt}% Modifier to remove overfull box warning
  \vspace{8pt}% Whitespace before the section title
  {\color{black!80} \huge #1 \rule[0.15\baselineskip]{\TotalSectionLength}{1pt}}% Print the title and auto-width rule
}

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=mainblue,mainblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand\skills[1]{ 
  \renewcommand{\skills}{
    \begin{tikzpicture}
      \foreach [count=\i] \x/\y in {#1}{
        \draw[fill=maingray,maingray] (0,\i) rectangle (6,\i+0.4);
        \draw[fill=white,mainblue](0,\i) rectangle (\y,\i+0.4);
        \node[above right] at (0,\i+0.4) {\x};
      }
    \end{tikzpicture}
  }
}

% Command for printing skills text
\newcommand\skillstext[1]{ 
  \renewcommand{\skillstext}{
    \begin{flushleft}
      \foreach [count=\i] \x/\y in {#1}{
        \x$ \star $\y
      }
    \end{flushleft}
  }
}

%----------------------------------------------------------------------------------------
%   SECTION TITLE BOXES
%----------------------------------------------------------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
  \tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, rounded corners, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2,text=white](char){#1};%
}

% Defines the text alignment for the right column
\newenvironment{rightcolumn}{\justifying}{\par\vspace{\baselineskip}}

%----------------------------------------------------------------------------------------
%   SECTION ENVIRONMENT
%----------------------------------------------------------------------------------------

% Command for sections with default icon
\newcommand{\cvsect}[1]{\section*{\round{#1}{mainblue}}}

% Command for sections with custom icon
\newcommand{\cvsectcustom}[2]{\section*{\round{#1}{#2}}}

%----------------------------------------------------------------------------------------
%   ENTRY ENVIRONMENT
%----------------------------------------------------------------------------------------

% Command for entries with date, title, company, and description
\newcommand{\entry}[4]{%
  \noindent\hangindent=2em\hangafter=1 % Indentation
  \parbox{\dimexpr\linewidth-2em}{%
    \textbf{#1} % Date
    \hfill % Horizontal separation
    \textbf{#2} % Title
    \newline % Line break
    \textit{#3} % Company
    \newline % Line break
    #4 % Description
  }
  \vspace{0.5em} % Vertical space
}

% Command for entries with date, title, company, and description (alternative format)
\newcommand{\entryalt}[4]{%
  \noindent\hangindent=2em\hangafter=1 % Indentation
  \parbox{\dimexpr\linewidth-2em}{%
    \textbf{#1} % Date
    \hfill % Horizontal separation
    \textbf{#2} % Title
    \newline % Line break
    \textit{#3} % Company
    \newline % Line break
    #4 % Description
  }
  \vspace{0.5em} % Vertical space
}

%----------------------------------------------------------------------------------------
%   ENTRYLIST ENVIRONMENT
%----------------------------------------------------------------------------------------

% Define the entrylist environment
\newenvironment{entrylist}{%
  \begin{itemize}[leftmargin=0em, itemindent=0em, itemsep=0.5em]
}{%
  \end{itemize}
}

% Command for entries in the entrylist environment
\newcommand{\entryitem}[4]{%
  \item
  \entry{#1}{#2}{#3}{#4}
}

%----------------------------------------------------------------------------------------
%   SEPARATOR COMMAND
%----------------------------------------------------------------------------------------

% Command for the separator between entries
\newcommand{\slashsep}{\hspace{3mm}/\hspace{3mm}}

%----------------------------------------------------------------------------------------
%   PAGE LAYOUT
%----------------------------------------------------------------------------------------

% Page margins will be set in the document configuration

%----------------------------------------------------------------------------------------
%   HEADER
%----------------------------------------------------------------------------------------

% Command for the header
\newcommand{\makeheader}{%
  \begin{minipage}[t]{0.5\textwidth} 
    \vspace{-\baselineskip} % Required for vertically aligning minipages
    
    { \fontsize{16}{20} \textcolor{black}{\textbf{\MakeUppercase{\cvname}}}} % First name
    
    \vspace{6pt}
    
    {\Large \cvjobtitle} % Career or current job title
  \end{minipage}
  \hfill
  \begin{minipage}[t]{0.2\textwidth} % 20% of the page width for the first row of icons
    \vspace{-\baselineskip} % Required for vertically aligning minipages
    
    % The first parameter is the FontAwesome icon name, the second is the box size and the third is the text
    \icon{Globe}{11}{\href{\cvsite}{\cvsite}}\\ 
    \icon{Phone}{11}{\cvnumberphone}\\
    \icon{MapMarker}{11}{\cvaddress}\\
    
  \end{minipage}
  \begin{minipage}[t]{0.27\textwidth} % 27% of the page width for the second row of icons
    \vspace{-\baselineskip} % Required for vertically aligning minipages
    
    \icon{Envelope}{11}{\href{mailto:\cvmail}{\cvmail}}\\    
    \icon{Github}{11}{\href{\cvgithub}{\cvgithub}}\\
    \icon{LinkedinSquare}{11}{\href{\cvlinkedin}{\cvlinkedin}}\\    
    
  \end{minipage}
}

%----------------------------------------------------------------------------------------
%   FOOTER
%----------------------------------------------------------------------------------------

% Command for the footer
\newcommand{\makefooter}{%
  \vfill
  \begin{center}
    \footnotesize{\textcolor{gray}{\cvdate}}
  \end{center}
}

%----------------------------------------------------------------------------------------
%   DOCUMENT SETUP
%----------------------------------------------------------------------------------------

% Set default values for CV info
\cvname{Vicente Lavagnino Gatica}
\cvjobtitle{Visiting Student @ MSc CS EPFL}
\cvdate{\today}
\cvlinkedin{/in/vicentelavagnino}
\cvgithub{github.com/VicenteLavagnino}
\cvmail{vicente.lavagninogatica@epfl.ch}
\cvnumberphone{+41 77 289 4018}
\cvaddress{Lausanne}
\cvsite{lavagnino.cl}

%----------------------------------------------------------------------------------------
%   END OF CLASS
%----------------------------------------------------------------------------------------

\endinput