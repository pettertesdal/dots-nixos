return {
	s("thero", {t("\\begin{theorem}["), i(1), t("]{"), i(2), t("}")}),
	s("equa", {t("\\begin{equation}"), i(1), t("end{equation}")}),
	s("stat", {t("\\begin{statement}"), i(1), t("end{statement}")})
}, {
	s("sct", { t("\\section{"), i(1), t("}") }),
	s("ssct", { t("\\subsection{"), i(1), t("}") })
}
