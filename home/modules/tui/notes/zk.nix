{ ... }:
{
  programs.zk = {
    enable = true;
    settings = {
      notebook = {
        dir = "~/documents/notes";
      };
      note = {
        language = "en";
        default-title = "untitled";
        filename = "{{title}}";
        extension = "md";
        template = "default.md";
        id-charset = "alphanum";
        id-length = 4;
        id-case = "lower";
      };
      alias = {
        # Edit the last modified note.
        edlast = "zk edit --limit 1 --sort modified- $@";

        # Edit the notes selected interactively among the notes created the last two weeks.
        recent = "zk edit --sort created- --created-after 'last two weeks' --interactive";

        # Show a random note.
        lucky = "zk list --quiet --format full --sort random --limit 1";
      };
      lsp.diagnostic = {
        wiki-title = "hint";
        dead-link = "error";
      };
      format.markdown = {
        link-format = "[[{{filename}}]]";
      };
      group.litterature = {
        paths = ["litterature"];
        note = {
          extension = "md";
          template = "litterature.md";
        };
      };
      extra = {
        author = "Petter Tesdal";
      };
      tool = {
        editor = "nvim";
        shell = "/run/current-system/sw/bin/zsh";
      };
    };
  };
}
