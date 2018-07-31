%figure()
%Only an instructional script.
xlim([])

set(gcf, 'PaperPosition', [0, 0, 8, 4]);
print(gcf, 'filename.png', '-dpng', '-r300');