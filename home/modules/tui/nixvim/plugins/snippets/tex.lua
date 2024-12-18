return {
	s("beg", {
      t("\\begin{"), i(1), t({"}", ""}),
      i(0),
      t({"", "\\end{"}), rep(1), t("}")
    }),
	s("thero", {
      t("\\begin{theorem}["),
      i(1),
      t({"]", ""}),
      i(2),
      t({"", "\\end{theorem}"})
    }),
	s("def", {
      t("\\begin{definition}["),
      i(1),
      t({"]", ""}),
      i(2),
      t({"", "\\end{definition}"})
    }),
	s("equa", {t({"\\begin{equation}", ""}), i(1), t("\\end{equation}")}),
	s("stat", {t({"\\begin{statement}", ""}), i(1), t("\\end{statement}")}),
	s("item", {t({"\\begin{itemize}", ""}), i(1), t("\\end{itemize}")})
}, {
	s("sct", { t("\\section{"), i(1), t({"}", ""}), i(2) }),
	s("ssct", { t("\\subsection{"), i(1), t({"}", ""}), i(2) }),
	s("bft", { t("\\textbf{"), i(1), t({"}"}), i(2) }),
	s("itt", { t("\\textit{"), i(1), t({"}"}), i(2) }),
	s("-i", { t("\\item "), i(1)}),
	s("mk", { t("$"), i(1), t("$")}),
	s("dm", { t({"\\[", ""}), i(1), t({"", "\\]"})})
}
