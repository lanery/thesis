\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2019/14/05 v0.1 (Unofficial) TUD thesis class]

% Options
\newif\if@dutch
\newif\if@english
\newif\if@nativefonts

\DeclareOption{dutch}{\@dutchtrue\@englishfalse}
\DeclareOption{english}{\@dutchfalse\@englishtrue}
\DeclareOption{nativefonts}{\@nativefontstrue}
\newif\if@print
\DeclareOption{print}{\@printtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{english}
\ProcessOptions\relax

% Base thesis class on book class
\LoadClass[10pt,openany]{book}

\RequirePackage{geometry}
% \geometry{a4paper,hscale=0.75,vscale=0.8}
% \geometry{b5paper,hscale=0.75,vscale=0.8}
%% Set the paper size to 17 by 24 cm, approximately halfway between A4 and A5.
\if@print
    %% In print mode we add a 3 mm bleed on the outside of the page.
    \geometry{
        papersize = {173mm,246mm},
        layoutsize = {167mm,240mm},
        layoutoffset = {3mm,3mm},
        bindingoffset = -3mm
    }
\else
    \geometry{papersize={170mm,240mm}}
\fi
%% We decrease the margins slightly from the default (scale = 0.7).
\geometry{hscale=0.75,vscale=0.8}

\RequirePackage{amsmath}
\RequirePackage{amssymb}

% English is the default language, but this can be changed to Dutch by
% specifying the 'dutch' option to the document class.
% Even for English reports, some sections might be in Dutch, for example on
% the title page, so also load dutch as alternative language in this case.
\RequirePackage{polyglossia}
\if@dutch
    \setdefaultlanguage{dutch}
\else
    \setdefaultlanguage{english}
    \setotherlanguage{dutch}
\fi

\RequirePackage[nooneline,
                small,
                figurename=Figure,
                labelfont=bf,
                labelsep=period]{caption}
\RequirePackage{fancyhdr}
\RequirePackage[flushmargin,hang]{footmisc}
% \RequirePackage{parskip}

\RequirePackage{graphicx}
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}
\RequirePackage[colorlinks = true,
                linkcolor = darkgray,
                urlcolor  = blue,
                citecolor = gray,
                anchorcolor = blue]{hyperref}

\RequirePackage[table]{xcolor}
\RequirePackage{metalogo}
\RequirePackage{tikz}
\RequirePackage[noindentafter]{titlesec}
\RequirePackage{titletoc}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{xkeyval}
\RequirePackage[export]{adjustbox}
\RequirePackage[normalem]{ulem}
\RequirePackage{unicode-math}
\RequirePackage{multirow}
\RequirePackage{booktabs}



% Set fonts
\setmainfont[
    Path=fonts/SourceSerifPro/,
    Extension=.otf,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-BoldItalic
]{SourceSerifPro}
\setsansfont[
    Path=fonts/FiraSans/,
    Extension=.otf,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-BoldItalic
]{FiraSans}
\setmonofont[
    Path=fonts/Inconsolata/,
    Extension=.otf,
]{Inconsolata}
\setmathfont[
    Path=fonts/TexGyrePagella/,
    Extension=.otf
]{TexGyrePagella-math}

% Create some custom font families
\newfontfamily\ThesisTitleFamily[
    Path=fonts/FiraSans/,
    Extension=.otf,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-BoldItalic
]{FiraSans}
\newfontfamily\ThesisSerifFamily[
    Path=fonts/SourceSerifPro/,
    Extension=.otf,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-BoldItalic
]{SourceSerifPro}
\newfontfamily\ThesisSansFamily[
    Path=fonts/FiraSans/,
    Extension=.otf,
    BoldFont=*-Bold,
    ItalicFont=*-Italic,
    BoldItalicFont=*-BoldItalic
]{FiraSans}




% Set title, chapter, section, header styles
\renewcommand*\familydefault{\rmdefault}
\def\titlefont{\ThesisSansFamily}
\def\largetitlefont{\ThesisTitleFamily}
% \def\titleshape{}
\def\titleshape{\scshape}  % style for titles is small caps.
\def\largetitleshape{\titleshape}
\def\largetitleseries{}
\def\largetitlestyle{\largetitlefont\largetitleseries\largetitleshape}
\def\chaptitlefamily{\ThesisSansFamily}
\def\titlestyle{\titlefont\titleshape\bfseries}
% \def\titlestyle{\titlefont\titleshape}
% \def\sectitlestyle{\ThesisSansFamily\titleshape\bfseries}
\def\sectitlestyle{\ThesisSansFamily\bfseries}
\def\chaptitlestyle{\chaptitlefamily}
\def\headerstyle{\titlestyle}


% Redefine the title command to accept an optional subtitle.
\renewcommand*\title[2][]{%
    \def\@subtitle{#1}%
    \def\@title{#2}%
    %% Add the title to the PDF meta data.
    \hypersetup{pdftitle=#2}%
}
% Redefine the author command to accept a first and last name, and to add the
% full name to the PDF meta data.
\renewcommand*\author[2]{%
    \def\@firstname{#1}%
    \def\@lastname{#2}%
    \hypersetup{pdfauthor=#1\ #2}%
}


% Use roman in quote environment
\renewenvironment{quote}
              {\list{}{\rightmargin\leftmargin}%
                \ThesisSerifFamily\selectfont\item\relax}
              {\endlist}

\colorlet{title}{black}

% Remove the header and page number on empty pages.
\def\cleardoublepage{%
    \clearpage%
    \if@twoside%
        \ifodd\c@page%
        \else%
            \thispagestyle{empty}%
            \vspace*{\fill}%
            \newpage%
        \fi%
    \fi%
}


% Page style for title pages.
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyfoot[C]{\titlefont\thepage}
}

% Fancy style for the main matter.
\fancypagestyle{mainmatter}{%
    \fancyhf{}
    %% Page numbers on the top left and top right.
    \fancyhead[LE,RO]{\titlefont\titleshape\thepage}
    %% Chapter name on the left (even) page.
    \fancyhead[RE]{\titlefont\titleshape\nouppercase{\leftmark}}
    %% Section name on the right (odd) page.
    \fancyhead[LO]{\titlefont\titleshape\nouppercase{\rightmark}}
}
% The mainmatter style is default for normal pages.
\pagestyle{mainmatter}


% Print the current chapter and section at the top of the page
% in the title color.
\renewcommand*\chaptermark[1]{\markboth{\thechapter.\ \titlefont\color{title}#1}{}}
\renewcommand*\sectionmark[1]{\markright{\thesection.\ \titlefont\color{title}#1}}
\newcommand*\setheader[1]{\markboth{\color{title}#1}{\titlefont\color{title}#1}}


% Change the headrule command (from fancyhdr.sty) to draw the line
% below the header in the title color.
\renewcommand*\headrule{%
    \if@fancyplain%
        \let\headrulewidth\plainheadrulewidth%
    \fi%
    {\color{title}\hrule\@height\headrulewidth\@width\headwidth}%
    \vskip-\headrulewidth%
}


% Draw the line above a footnote in the title color as well.
\renewcommand*\footnoterule{%
    \vspace*{-3pt}%
    {\color{title}\hrule width 0.5\textwidth height 0.4pt}%
    \vspace*{2.6pt}%
}


% A part title starts with a huge (96pt) bold black number, flushed to the
% right, followed by the part name on the next line in the title color.
\titleformat{\part}[display]
    {\flushright}
    {\fontsize{\@largetitlesize}{\@largetitlesize}\selectfont\bfseries\thepart}
    {0pt}
    {\Huge\color{title}}

% Separate the title from the text by two empty lines.
\titlespacing{\part}{0pt}{0pt}{2\baselineskip}
% In the table of contents, the part name is preceded by an empty line, printed
% in bold, and not followed by a line of dots.
\dottedcontents{part}[0em]{\vspace{\baselineskip}\titlefont\bfseries}{1.5em}{0pc}


% Chapter titles have the same layout as parts.
\titleformat{\chapter}[display]
    {\flushright\largetitlestyle}
    {\fontsize{96}{96}\selectfont\thechapter}
    {0pt}
    {\chaptitlestyle\Huge\color{title}}
\titlespacing{\chapter}{0pt}{0pt}{2\baselineskip}
% In the table of contents, a chapter is similar to a part, except that it is
% preceded by half an empty line.
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\titlefont\bfseries}{1.5em}{0pc}


% Section titles start with the number in bold, followed by the name printed
% in the title color.
\titleformat{\section}
    {\Large\sectitlestyle}
    {\bfseries\thesection.\ }
    {0pt}
    {\color{title}}
% Sections are preceded by a 4pt space.
\titlespacing{\section}{0pt}{\baselineskip}{4pt}
% In the table of contents, section names are followed by a line of dots 8pt
% apart.
\dottedcontents{section}[3.8em]{\titlefont}{2.3em}{8pt}


% Subsection titles have the same layout as section titles,
% except in a smaller font.
\titleformat{\subsection}
    {\large\sectitlestyle}
    {\bfseries\thesubsection.\ }
    {0pt}
    {\color{title}}
\titlespacing{\subsection}{0pt}{\baselineskip}{3pt}
\dottedcontents{subsection}[7em]{\titlefont}{3.2em}{8pt}

% Subsubsections have the same font and color as sections and subsections, but
% are not preceded by a number.
\titleformat{\subsubsection}
    {\normalsize\sectitlestyle}
    {\bfseries\thesubsubsection.\ }
    {0pt}
    {\color{title}}
\titlespacing{\subsubsection}{0pt}{\baselineskip}{2pt}
% Subsubsections are preceded by an empty line and do not appear in the table
% of contents.


% Some custom environments
% ------------------------
% Create a new header style (effectively a sub-sub-sub-section, based on \paragraph)
\newcommand{\header}[1]{\paragraph{#1}\mbox{}\\}

% Define an unnumbered footnote command
\def\blfootnote{\xdef\@thefnmark{}\@footnotetext}

% The abstract environment is used for the abstract of a chapter.
\newenvironment{abstract}{%
    \list{}{\leftmargin\rightmargin}%
    \item%
    \relax%
    \rmfamily\small%
}{%
    \endlist%
}

% Color the bullets of the itemize environment and make the symbol
% of the third level a diamond instead of an asterisk.
\renewcommand*\labelitemi{\color{title}\textbullet}
\renewcommand*\labelitemii{\color{title}--}
\renewcommand*\labelitemiii{\color{title}$\diamond$}
\renewcommand*\labelitemiv{\color{title}\textperiodcentered}


% % Hyperlinks are cyan, except in print mode, when they are all black.
% \hypersetup{
%     colorlinks=true,
%     citecolor=title,
%     linkcolor=title,
%     urlcolor=title
% }
